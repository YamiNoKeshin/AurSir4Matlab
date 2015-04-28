classdef Router < handle
    properties
        p
        ctx
        docked
        incoming
        outgoing
        pending
        buffer
    end
    
    methods (Access = private)
        function [result, found] = wait_docked_(obj)
            found = false;
            if numel(obj.docked) == 0
                result = 0;
                return
            end
            found = true;
            result = obj.docked;
        end
        
        function [result, found] = wait_import_added_(obj, key)
            map = obj.pending(int64(MessageType.IMPORT_ADDED));
            if ~isKey(map, key)
                map(key) = 0;
            end
            found = false;
            result = map(key);
            if ~isnumeric(result)
                remove(map, key);
                found = true;
            end
        end
        
        function [result, found] = wait_export_added_(obj, key)
            map = obj.pending(int64(MessageType.EXPORT_ADDED));
            if ~isKey(map, key)
                map(key) = 0;
            end
            found = false;
            result = map(key);
            if ~isnumeric(result)
                remove(map, key);
                found = true;
            end
        end
        
        function [result, found] = wait_for_request_(obj, key)
            map = obj.pending(int64(MessageType.REQUEST));
            if ~isKey(map, key)
                map(key) = 0;
            end
            found = false;
            result = map(key);
            if ~isnumeric(result)
                remove(map, key);
                found = true;
            end
        end
    end
    
    methods
        function obj = Router(uuid)
            obj.ctx = zmq.core.ctx_new();
            obj.incoming = ZeroMQIncoming(obj.ctx, obj);
            obj.outgoing = ZeroMQOutgoing(obj.ctx, obj.incoming.port, uuid);
            obj.outgoing.start();
            obj.incoming.start();
            obj.docked = [];
            obj.pending = containers.Map('KeyType', 'int64', 'ValueType', 'any');
            obj.pending(int64(MessageType.IMPORT_ADDED)) = containers.Map();
            obj.pending(int64(MessageType.EXPORT_ADDED)) = containers.Map();
            obj.pending(int64(MessageType.RESULT)) = containers.Map();
            obj.pending(int64(MessageType.REQUEST)) = containers.Map();
            obj.buffer = {};
        end
        
        function [result, found] = wait(obj, key, type)
            switch type
                case MessageType.DOCK
                    [result, found] = obj.wait_docked_();
                case MessageType.ADD_IMPORT
                    [result, found] = obj.wait_import_added_(key);
                case MessageType.ADD_EXPORT
                    [result, found] = obj.wait_export_added_(key);
                case MessageType.REQUEST
                    [result, found] = obj.wait_for_request_(key);
                otherwise
                    result = 0; 
                    found = false;
            end
        end
        
        function t = send(obj, msg)
            obj.outgoing.send(msg);
            key = 0;
            if msg.MessageType ~= MessageType.DOCK
                key = strcat(msg.AppKey.ApplicationKeyName, cell2mat(msg.Tags));
            end
            timer_fcn = {@router_timer_fcn, obj, key, msg.MessageType};
            t = timer('Period', 0.1, 'ExecutionMode', 'fixedSpacing', 'TimerFcn', timer_fcn, 'TasksToExecute', 600);
            start(t);
        end
        
        function stop(obj)
            obj.incoming.stop();
            obj.outgoing.stop();
            obj.docked = [];
        end
        
        function recv(obj, buffer, more)
            if more > 0
                obj.buffer{end+1} = buffer;
                return;
            else
                receivedMessage = obj.buffer;
                obj.buffer = {};
            end
            type = MessageType(str2num(receivedMessage{2}));
            if type ~= MessageType.DOCKED
                map = obj.pending(int64(type));
            end
            msg = receivedMessage{4};
            switch type
                case MessageType.DOCKED
                    m = loadjson(msg);
                    obj.docked = [logical(m.Ok)];
                case MessageType.IMPORT_ADDED
                    m = loadjson(msg);
                    ia = ImportedAppkey(m, obj);
                    disp(ia);
                    key = strcat(m.AppKey.ApplicationKeyName, cell2mat(m.Tags));
                    map(key) = ia;
                case MessageType.EXPORT_ADDED
                    m = loadjson(msg);
                    ea = ExportedAppkey(m, obj);
                    key = strcat(m.AppKey.ApplicationKeyName, cell2mat(m.Tags));
                    map(key) = ea;
                case MessageType.RESULT
                    m = AurSirMessage.fromStruct('ResultMessage',loadjson(msg));
                    if m.CallType == 0
                        key = m.Uuid;
                    else
                        key = m.ImportId;
                    end
                    map(key) = m;
                case MessageType.REQUEST
                    m = AurSirMessage.fromStruct('RequestMessage',loadjson(msg));
                    key = m.exportId;
                    map(key) = m;
                otherwise
                    error('Unsupported MessageType');
            end
        end
        
        function t = get_request(obj, key)
            timer_fcn = {@router_timer_fcn, obj, key, MessageType.REQUEST};
            t = timer('Period', 0.1, 'ExecutionMode', 'fixedSpacing', 'TimerFcn', timer_fcn, 'TasksToExecute', 600);
            start(t);
        end
        
        function t = get_result(obj, key)
            timer_fcn = {@router_timer_fcn, obj, key, MessageType.RESULT};
            t = timer('Period', 0.1, 'ExecutionMode', 'fixedSpacing', 'TimerFcn', timer_fcn, 'TasksToExecute', 600);
            start(t);
        end
        
    end
    
end


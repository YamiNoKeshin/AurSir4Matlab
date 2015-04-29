classdef ImportedAppkey
    properties
        id
        appKey
        tags
        exported
        router
    end
    
    methods (Access = private)
        function call_(obj, Uuid, functionName, parameter, callType)
            request = base64_encode(savejson('', parameter, 'ParseLogical', 1, 'Compact', 1));
            m = RequestMessage(obj.appKey.ApplicationKeyName, functionName, obj.id, Uuid, callType, obj.tags, request);
            obj.router.send(m);
        end
    end
    
    methods
        function obj = ImportedAppkey(importAddedMessage, router)
            obj.id = importAddedMessage.ImportId;
            obj.appKey = importAddedMessage.AppKey;
            obj.tags = importAddedMessage.Tags;
            obj.exported = importAddedMessage.Exported;
            obj.router = router;
        end
        
        function result = call(obj, functionName, parameter)
            Uuid = gen_uuid();
            obj.call_(Uuid, functionName, parameter, CallType.ONE2ONE);
            t = obj.router.get_result(Uuid);
            wait(t);
            result = get(t, 'UserData');
        end
        
        function trigger(obj, functionName, parameter)
            Uuid = gen_uuid();
            obj.call_(Uuid, functionName, parameter, CallType.MANY2ONE);
        end
        
        function callAll(obj, functionName, parameter)
            Uuid = gen_uuid();
            obj.call_(Uuid, functionName, parameter, CallType.ONE2MANY);
        end
        
        function triggerAll(obj, functionName, parameter)
            Uuid = gen_uuid();
            obj.call_(Uuid, functionName, parameter, CallType.MANY2MANY);
        end
        
        function result = listen(obj)
            t = obj.router.get_result(obj.id);
            wait(t);
            result = get(t, 'UserData');
        end
        
        function start_listen(obj, functionName)
            m = StartListenMessage(obj.id, functionName);
            obj.router.send(m);
        end
        
        function stop_listen(obj, functionName)
            m = StopListenMessage(obj.id, functionName);
            obj.router.send(m);
        end
    end
    
end


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
            request = base64_encode(savejson(parameter));
            m = RequestMessage(obj.appKey.AppKeyName, functionName, obj.id, Uuid, callType, obj.tags, request);
            obj.router.send(m);
        end
    end
    
    methods
        function obj = ImportedAppkey(importAddedMessage, router)
            obj.id = importAddedMessage.ExportId;
            obj.appKey = importAddedMessage.AppKey;
            obj.tags = importAddedMessage.Tags;
            obj.exported = importAddedMessage.Exported;
            obj.router = router;
        end
        
        function result = call(obj, functionName, parameter)
            Uuid = gen_uuid();
            obj.call_(Uuid, functionName, parameter, CallType.ONE2ONE);
            disp('called');
            t = obj.router.get_result(obj.id);
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
        
        function startListen(obj, functionName)
            m = StartListenMessage(obj.id, functionName);
            obj.router.send(m);
        end
        
        function stopListen(obj, functionName)
            m = StopListenMessage(obj.id, functionName);
            obj.router.send(m);
        end
    end
    
end


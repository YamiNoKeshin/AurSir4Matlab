classdef ExportedAppkey
    properties
        id
        appKey
        tags
        router
    end
    
    methods
        function obj = ExportedAppkey(exportAddedMessage, router)
            obj.id = exportAddedMessage.ExportId;
            obj.appKey = exportAddedMessage.AppKey;
            obj.tags = exportAddedMessage.Tags;
            obj.router = router;
        end
        
        function req = request(obj)
            t = obj.router.get_request(obj.id);
            wait(t);
            req = get(t, 'UserData');
        end
        
        function reply(obj, request, result)
            m = ResultMessage(request, obj.id, result);
            obj.router.send(m);
        end
    end
    
end


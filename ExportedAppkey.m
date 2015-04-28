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
            t = ResultMessage(request, obj.id, result);
            wait(t);
            req = get(t, 'UserData');
        end
    end
    
end


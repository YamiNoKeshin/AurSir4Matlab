classdef AurSirInterface
    properties
        appName
        uuid
        router
    end
    
    methods (Access = private)
        function dock_(obj)
            m = DockMessage(obj.appName, {'JSON'});
            t = obj.router.send(m);
            wait(t);
            ok = get(t, 'UserData');
            if ok
                disp('Sucessfully docked');
            else
                disp('Docking failed');
            end
        end
    end
    
    methods
        function obj = AurSirInterface(appName)
            addpath(genpath('.'));
            obj.appName = appName;
            obj.uuid = gen_uuid();
            obj.router = Router(obj.uuid);
            obj.dock_();
        end
        
        function stop(obj)
            disp('Stopping');
            obj.router.stop();
        end
        
        function import = add_import(obj, appkey, tags)
            m = AddImportMessage(appkey, tags);
            t = obj.router.send(m);
            wait(t);
            import = get(t, 'UserData');
        end
        
        function export = add_export(obj, appkey, tags)
            m = AddExportMessage(appkey, tags);
            t = obj.router.send(m);
            wait(t);
            export = get(t, 'UserData');
        end
    end
    
end


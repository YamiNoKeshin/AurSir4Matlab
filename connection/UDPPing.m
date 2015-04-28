classdef UDPPing
    properties
        t
        udp
        uuid
    end
    
    methods
        function obj = UDPPing(uuid)
            obj.uuid = uuid;
            obj.udp = udp('localhost', 5557);
            fopen(obj.udp);
        end
        
        function ping(obj)
            fwrite(obj.udp, obj.uuid);
        end
        
        function stop(obj)
            fclose(obj.udp);
        end
    end
    
    
end


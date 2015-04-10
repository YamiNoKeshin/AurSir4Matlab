classdef StopListenMessage < StartListenMessage
    methods
        function obj = StopListenMessage
            obj.MessageType = MessageType.STOP_LISTEN;
        end
    end
end


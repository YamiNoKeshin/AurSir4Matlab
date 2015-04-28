classdef StopListenMessage < StartListenMessage
    methods
        function obj = StopListenMessage(ImportId, FunctionName)
            obj = obj@StartListenMessage(ImportId, FunctionName);
            obj.MessageType = MessageType.STOP_LISTEN;
        end
    end
end


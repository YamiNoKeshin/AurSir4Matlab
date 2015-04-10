classdef ExportAddedMessage < AddExportMessage
    methods
        function obj = ExportAddedMessage
            obj.MessageType = MessageType.EXPORT_ADDED;
        end
    end    
end


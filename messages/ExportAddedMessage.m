classdef ExportAddedMessage < AddExportMessage
    methods
        function obj = ExportAddedMessage(AppKey, Tags, ExportId)
            obj = obj@AddExportMessage(AppKey, Tags, ExportId);
            obj.MessageType = MessageType.EXPORT_ADDED;
        end
    end    
end


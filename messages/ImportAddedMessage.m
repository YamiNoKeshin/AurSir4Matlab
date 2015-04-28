classdef ImportAddedMessage < AddImportMessage
    methods
        function obj = ImportAddedMessage(AppKey, Tags, ImportId)
            obj = obj@AddImportMessage(AppKey, Tags, ImportId);
            obj.MessageType = MessageType.IMPORT_ADDED;
        end
    end    
end
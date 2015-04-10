classdef ImportAddedMessage < AddImportMessage
    methods
        function obj = ImportAddedMessage
            obj.MessageType = MessageType.IMPORT_ADDED;
        end
    end    
end
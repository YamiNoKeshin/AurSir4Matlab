classdef RemoveImportMessage < AurSirMessage
    properties
        ImportId
    end
    
    methods
        function obj = RemoveImportMessage(ImportId)
            obj.ImportId = ImportId
            obj.MessageType = MessageType.REMOVE_IMPORT;
        end
        
        function obj = set.ImportId(obj, value)
            if isa(value, 'char')
                obj.ImportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
    end
    
end


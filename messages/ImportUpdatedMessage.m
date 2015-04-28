classdef ImportUpdatedMessage < AurSirMessage
    properties
        ImportId
        Exported
    end
    
    methods
        function obj = ImportUpdatedMessage(ImportId, Exported)
            obj.ImportId = ImportId;
            obj.Exported = Exported;
            obj.MessageType = MessageType.IMPORT_UPDATED;
        end
        
        function obj = set.ImportId(obj, value)
            if isa(value, 'char')
                obj.ImportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.Exported(obj, value)
            if isa(value, 'logical')
                obj.Exported = value;
            else
                error(strcat('Wrong type, expected logical, got ', class(value)));
            end
         end
    end
    
end


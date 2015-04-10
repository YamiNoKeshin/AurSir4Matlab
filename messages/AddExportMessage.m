classdef AddExportMessage < AurSirMessage
    properties
        AppKey
        Tags
        ExportId
    end
    
    methods
        function obj = AddExportMessage
            obj.MessageType = MessageType.ADD_EXPORT;
        end
        
        function obj = set.AppKey(obj, value)
            if isa(value, 'struct') && numel(fieldnames(value)) > 0
                obj.AppKey = value;
            else
                error(strcat('Wrong type, expected non-empty struct, got ', class(value)));
            end
        end
        
        function obj = set.Tags(obj, value)
            if isa(value, 'cell') && numel(value) > 0
                obj.Tags = value;
            else
                error(strcat('Wrong type, expected non-empty cell, got ', class(value)));
            end
        end
        
        function obj = set.ExportId(obj, value)
            if isa(value, 'char')
                obj.ExportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
    end
    
end


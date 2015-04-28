classdef AddImportMessage < AurSirMessage
    properties
        AppKey
        Tags
    end
    
    methods
        function obj = AddImportMessage(AppKey, Tags)
            obj.AppKey = AppKey;
            obj.Tags = Tags;
            obj.MessageType = MessageType.ADD_IMPORT;
        end
        
        function obj = set.AppKey(obj, value)
            if isa(value, 'struct') && numel(fieldnames(value)) > 0
                obj.AppKey = value;
            else
                error(strcat('Wrong type, expected non-empty struct, got ', class(value)));
            end
        end
        
        function obj = set.Tags(obj, value)
            if isa(value, 'cell')
                obj.Tags = value;
            else
                error(strcat('Wrong type, expected non-empty cell, got ', class(value)));
            end
        end
    end
    
end


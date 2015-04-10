classdef ResultMessage < AurSirMessage
    properties
        AppKeyName
        FunctionName
        ImportId
        ExportId
        Uuid
        CallType
        Codec
        Tags
        Result
    end
    
    methods
        function obj = ResultMessage
            obj.MessageType = MessageType.RESULT;
        end
        
        function obj = set.AppKeyName(obj, value)
            if isa(value, 'char')
                obj.AppKeyName = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.FunctionName(obj, value)
            if isa(value, 'char')
                obj.FunctionName = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.ImportId(obj, value)
            if isa(value, 'char')
                obj.ImportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.ExportId(obj, value)
            if isa(value, 'char')
                obj.ExportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.Uuid(obj, value)
            if isa(value, 'char')
                obj.Uuid = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.CallType(obj, value)
            if isa(value, 'CallType')
                obj.CallType = int64(value);
            else
                error(strcat('Wrong type, expected CallType, got ', class(value)));
            end
        end
        
        function obj = set.Codec(obj, value)
            if isa(value, 'char')
                obj.Codec = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.Tags(obj, value)
            if isa(value, 'cell') && numel(value) > 0
                obj.Tags = value;
            else
                error(strcat('Wrong type, expected non-empty cell, got ', class(value)));
            end
        end
        
        function obj = set.Result(obj, value)
            if isa(value, 'char')
                obj.Result = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
    end
    
end


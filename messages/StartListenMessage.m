classdef StartListenMessage < AurSirMessage
    properties
        ImportId
        FunctionName
    end
    
    methods
        function obj = StartListenMessage
            obj.MessageType = MessageType.LISTEN;
        end
        
        function obj = set.ImportId(obj, value)
            if isa(value, 'char')
                obj.ImportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.FunctionName(obj, value)
            if isa(value, 'char')
                obj.ImportId = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
    end
    
end


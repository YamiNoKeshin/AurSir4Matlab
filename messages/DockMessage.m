classdef DockMessage < AurSirMessage
    properties
        AppName
        Codecs
    end
    
    methods
        function obj = DockMessage
            obj.MessageType = MessageType.DOCK;
        end
        
        function obj = set.AppName(obj, value)
            if isa(value, 'char')
                obj.AppName = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function obj = set.Codecs(obj, value)
            if isa(value, 'cell') && numel(value) > 0
                obj.Codecs = value;
            else
                error(strcat('Wrong type, expected non-empty cell, got ', class(value)));
            end
        end
    end
    
end


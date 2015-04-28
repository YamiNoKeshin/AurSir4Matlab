classdef DockedMessage < AurSirMessage
    properties
        Ok
    end
    methods
        function obj = DockedMessage
            obj.MessageType = MessageType.DOCKED;
        end
        
         function obj = set.Ok(obj, value)
            if isa(value, 'logical')
                obj.Ok = value;
            elseif isnumeric(value)
                obj.Ok = logical(value);
            else
                error(strcat('Wrong type, expected logical, got ', class(value)));
            end
         end
    end
end


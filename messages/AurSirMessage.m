classdef (Abstract) AurSirMessage
    properties
        MessageType
    end
    
    methods
        function obj = set.MessageType(obj, value)
            if isa(value, 'MessageType')
                obj.MessageType = int64(value);
            else
                error(strcat('Wrong type, expected MessageType, got ', class(value)));
            end
        end
        
        function enc = encoded(obj, codec)
            warning('off', 'MATLAB:structOnObject');
            addpath('../external/jsonlab');
            if nargin < 2
                codec = 'JSON';
            end
            o = struct(obj);
            switch codec
                case 'JSON'
                    enc = savejson('',o, 'ParseLogical', 1, 'Compact', 1);
                otherwise
                    error(strcat(codec, ' not supported'));
            end
            warning('on', 'MATLAB:structOnObject');
        end
    end
    
end


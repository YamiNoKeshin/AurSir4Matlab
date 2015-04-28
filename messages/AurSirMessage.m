classdef (Abstract) AurSirMessage
    properties
        MessageType
    end
    
%     methods (Static)
%         function c = fromStruct(className, s)
%             c = feval(className);
%             fields = fieldnames(s);
%             disp(fields);
%             for ii = 1:numel(fields)
%                 f = fields{ii};
%                 if isprop(c, f)
%                     disp(f);
%                     c.(f) = s.(f);
%                 else
%                     error('Incompatible Struct');
%                 end
%             end
%         end
%     end
    
    methods
        function obj = set.MessageType(obj, value)
            if isa(value, 'MessageType')
                obj.MessageType = int64(value);
            elseif isnumeric(value) && value >=0 && value <=15
                obj.MessageType = value;
            else
                error(strcat('Wrong type, expected MessageType, got  ', class(value)));
            end
        end
        
        function enc = encoded(obj, codec)
            warning('off', 'MATLAB:structOnObject');
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


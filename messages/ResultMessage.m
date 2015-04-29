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
        function obj = ResultMessage(Request, ExportId, Result)
            if nargin > 0
                if isa(Request, 'char')
                    r = loadjson(Request);
                elseif isa(Request, 'RequestMessage') || isa(Request, 'struct')
                    r = Request;
                else
                    error('Not a valid request');
                end
                
                fields = fieldnames(r);
                for ii = 1:numel(fields)
                    f = fields{ii};
                    if isprop(obj, f)
                        try
                            obj.(f) = r.(f);
                        catch e
                        end
                    end
                end
            end
            if nargin > 1
                obj.ExportId = ExportId;
            end
            if nargin > 2
                obj.Result = base64_encode(savejson('', Result, 'ParseLogical', 1, 'Compact', 1));
            end
            
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
            elseif isnumeric(value)
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
            if isa(value, 'cell')
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
        
        function r = decode(obj)
            res = base64_decode(obj.Result);
            res = sprintf('%s', res);
            res = strrep(res, '\"', '"');
            r = loadjson(res(2:end-1));
        end
    end
    
end


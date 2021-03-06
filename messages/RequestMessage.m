classdef RequestMessage < AurSirMessage
    properties
        AppKeyName
        FunctionName
        ImportId
        ExportId
        Uuid
        CallType
        Codec
        Tags
        Request
    end
    
    methods
        function obj = RequestMessage(AppKeyName, FunctionName, ImportId, Uuid, CallType, Tags, Request)
            obj.AppKeyName = AppKeyName;
            obj.FunctionName = FunctionName;
            obj.ImportId = ImportId;
            obj.Uuid = Uuid;
            obj.CallType = CallType;
            obj.Tags = Tags;
            obj.Request = Request;
            obj.MessageType = MessageType.REQUEST;
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
            if isa(value, 'cell')
                obj.Tags = value;
            else
                error(strcat('Wrong type, expected non-empty cell, got ', class(value)));
            end
        end
        
        function obj = set.Request(obj, value)
            if isa(value, 'char')
                obj.Request = value;
            else
                error(strcat('Wrong type, expected char, got ', class(value)));
            end
        end
        
        function r = decode(obj)
            req = base64_decode(obj.Request);
            req = sprintf('%s', req);
            req = strrep(req, '\"', '"');
            r = loadjson(req(2:end-1));
        end
        
    end
    
end


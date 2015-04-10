classdef MessageType < int64
    enumeration
        DOCK (0)
        DOCKED (1)
        LEAVE (2)
        REQUEST (3)
        RESULT (4)
        ADD_EXPORT (5)
        UPDATE_EXPORT (6)
        EXPORT_ADDED (7)
        ADD_IMPORT (8)
        UPDATE_IMPORT (9)
        IMPORT_ADDED (10)
        IMPORT_UPDATED (11)
        LISTEN (12)
        STOP_LISTEN (13)
        REMOVE_EXPORT (14)
        REMOVE_IMPORT (15)
    end
end


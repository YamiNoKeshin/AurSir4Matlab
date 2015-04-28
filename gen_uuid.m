function [ uuid ] = gen_uuid(  )
    import java.util.UUID;
    u = UUID.randomUUID();
    low = typecast(u.getLeastSignificantBits(), 'uint64');
    high = typecast(u.getMostSignificantBits(), 'uint64');
    uuid = sprintf('%X%X', high, low);
end


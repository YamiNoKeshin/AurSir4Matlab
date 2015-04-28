function udp_ping_stop_fcn( t, ~ )
    udp = get(t, 'UserData');
    udp.stop();
end


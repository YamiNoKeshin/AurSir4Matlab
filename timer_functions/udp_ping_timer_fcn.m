function udp_ping_timer_fcn( t, ~ )
    udp = get(t, 'UserData');
    udp.ping();
end


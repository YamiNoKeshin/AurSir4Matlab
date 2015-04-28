function router_timer_fcn( t, ~, router, key, type )
    [result, found] = router.wait(key, type);
    if found
        stop(t);
        set(t, 'UserData', result);
    end
end


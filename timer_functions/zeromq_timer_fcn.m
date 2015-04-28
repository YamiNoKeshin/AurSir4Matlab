function zeromq_timer_fcn( ~, ~, socket, router)
    try
        buffer = zmq.core.recv(socket, 'ZMQ_DONTWAIT');
        more = zmq.core.getsockopt(socket, 'ZMQ_RCVMORE');
        router.recv(char(buffer), more);
    catch e
        
    end
end


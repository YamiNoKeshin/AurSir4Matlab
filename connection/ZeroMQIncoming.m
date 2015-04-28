classdef ZeroMQIncoming < handle
    properties
        ctx
        router
        socket
        port
        t
    end
    methods
        function obj = ZeroMQIncoming(ctx, router)
            obj.ctx = ctx;
            obj.router = router;
            obj.socket = zmq.core.socket(obj.ctx, 'ZMQ_ROUTER');
            
            zmq.core.bind(obj.socket, 'tcp://127.0.0.1:*');
            endpoint = strsplit(zmq.core.getsockopt(obj.socket, 'ZMQ_LAST_ENDPOINT'),':');
            obj.port = str2num(endpoint{3});
            timer_fcn = {@zeromq_timer_fcn, obj.socket, obj.router};
            obj.t = timer('Period', 0.1, 'ExecutionMode', 'fixedDelay', 'TimerFcn', timer_fcn);
            
        end
        
        function start(obj)
           start(obj.t);
        end
        
        function stop(obj)
            stop(obj.t);
        end
    end
    
end


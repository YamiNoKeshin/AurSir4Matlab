classdef ZeroMQOutgoing < handle
    properties
        ctx
        socket
        port
        t
        running
    end
    
    methods (Access = private)
        function send_(obj, msg)
            zmq.core.send(obj.socket, uint8(sprintf('%d', msg.MessageType)), 'ZMQ_DONTWAIT', 'ZMQ_SNDMORE');
            zmq.core.send(obj.socket, uint8('JSON'), 'ZMQ_DONTWAIT', 'ZMQ_SNDMORE');
            zmq.core.send(obj.socket, uint8(msg.encoded()), 'ZMQ_DONTWAIT', 'ZMQ_SNDMORE');
            zmq.core.send(obj.socket, uint8(sprintf('%d', obj.port)), 'ZMQ_DONTWAIT');
        end
    end
    
    methods
        function obj = ZeroMQOutgoing(ctx, port, uuid)
            obj.ctx = ctx;
            obj.port = port;
            obj.socket = zmq.core.socket(obj.ctx, 'ZMQ_DEALER');
            zmq.core.setsockopt(obj.socket, 'ZMQ_IDENTITY', uuid);
            zmq.core.connect(obj.socket, 'tcp://127.0.0.1:5555');
            udpPing = UDPPing(uuid);
            obj.t = timer('Period', 1.0, 'ExecutionMode', 'fixedDelay', 'UserData', udpPing);
            obj.t.TimerFcn = @udp_ping_timer_fcn;
            obj.t.StopFcn = @udp_ping_stop_fcn;
            obj.running = 0;
        end
        
        function send(obj, msg)
            if obj.running
                obj.send_(msg);
            end
        end
        
        function start(obj)
            obj.running = 1;
            start(obj.t);
        end
        
        function stop(obj)
            obj.running = 0;
            stop(obj.t);
        end
        
    end
    
end


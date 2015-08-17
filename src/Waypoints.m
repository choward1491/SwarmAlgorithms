classdef Waypoints < handle
    
    properties
        queue;
        cwp; % Current Way Point
        thresh;
        
    end
    
    
    methods
        
        function obj = Waypoints( thresh )
            obj.queue = Queue();
            obj.cwp = [];
            obj.thresh = thresh;
        end% Waypoints End
        
        function addPoint( obj, point )
            obj.queue.push( point );
        end% addPoint End
        
        function out = getWaypoint( obj, pos )
            if( isempty( obj.cwp ) )
                obj.cwp = obj.queue.pop();
            else
                del = pos - obj.cwp;
                d = sqrt( dot(del,del) );
                if( d < obj.thresh && obj.queue.count > 0 )
                    obj.cwp = obj.queue.pop();
                end
            end
            
            out = obj.cwp;
        end% getWaypoint End
        
    end
    
    
end
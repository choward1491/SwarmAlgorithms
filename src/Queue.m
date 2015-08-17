classdef Queue < handle
    
    properties
        items;
        count;
    end
    
    
    methods
        
        function obj = Queue()
            obj.items = [];
            obj.count = 0;
        end
        
        function push( obj, v )
            if( ~isempty(v) )
                obj.count = obj.count + 1;
                obj.items(obj.count).d =v;
            end
        end
        
        function v = pop( obj )
            if( obj.count > 0 )
                v = obj.items(1).d;
                obj.items = obj.items(2:end);
                obj.count = obj.count - 1;
            else
                v = [ ];
            end
        end
        
    end
    
    
    
    
end
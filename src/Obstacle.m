classdef Obstacle < handle
    properties
        pos;            % position vector of obstacle
        radius;        % cushion radius so that nothing hits the obstacle
        dim;            % dimensions of the problem
    end
    
    
    %
    % 
    %   Public methods for user to call
    %
    %
    methods
        
        %
        % Constructor function for obstacles
        %
        function obj = Obstacle(pos, radius)
            obj.pos = pos;
            obj.radius = radius;
            obj.dim = length(pos);
            
        end% End the constructor function
        
        
        %
        % Find potential obstacle creates for a drone at position pos_drone
        %
        function val = GetPotential( obj, pos_drone)
            % Find the position difference between the
            % drone and the obstacle
            del = pos_drone - obj.pos;
            
            % Find the dot product of the difference vector
            r2 = dot(del,del);
            
            % Find the length of the difference vector
            r = sqrt(r2);
            
             val = obj.GetObstaclePotential( r );
            
            
        end% End Potential Function
        
        
    %
    % End public methods
    %
    end
    
    
    %
    %
    % Private Methods
    %
    %
    methods (Access = private)
        
        %
        % Get potential caused by obstacle
        %
        function val = GetObstaclePotential( obj, r  ) 
            % Create a potential function that increases for r >
            % obj.radius and for r <= obj.radius such that r = obj.radius
            % becomes a minimum
                R = obj.radius;
                if( r < R )
                    val = 1e3*exp( -(r/R)^2 );
                else
                    val = 0;
                end
            
        end% End center drone potential function
        
        
    %
    % End private methods
    %
    end
    
    
    
%
% End the class definition
%
end
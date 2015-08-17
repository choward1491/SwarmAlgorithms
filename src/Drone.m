classdef Drone < handle
    
    properties
        radius;             % Cushion radius to ensure nothing hits the drone
        pos;                 % The position vector of the drone
        type;                % type = 1 is an outside drone, type = 2 is a center drone (only one of these)
        dim;                 % dimensions of the problem
    end
    
    
    
    
    %
    %
    % These are public functions for the user to call
    %
    %
    methods 
        
        
        %
        % Constructor method for drones
        %
        function obj = Drone(radius, pos, type)
            obj.radius = radius;
            obj.pos = pos;
            obj.type = 1;
            obj.dim = length(pos);
        end % End constructor method
        
        
        
        %
        % Find potential energy another drone feels based on the position of this drone
        %
        function val = GetPotential(obj, pos_drone ) 
            del = pos_drone - obj.pos; % Find the difference in their position vectors
            r2 = dot(del,del);                 % Find the dot product of the difference vector
            r = sqrt(r2);                          % Find the distance of the difference vector;
            
            if( obj.type <= 2 ) % If the drone is an outside drone
                
                val = obj.GetOutsidePotential( r );
                
            else                       % If the drone is a center drone
                val = obj.GetCenterPotential( r );
                
            end % End obj.type if statement
            
        end % End function to get potential
        
        
    %    
    %    End the public functions
    %    
    end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    
    
    
    %
    %
    % These are private functions for only internal methods to call
    %
    %
    methods %(Access = private)
        
        
        %
        % Get potential if this drone is a center drone
        %
        function val = GetCenterPotential( obj, r ) 
            % Create a potential function that increases for r >
            % obj.radius and for r <= obj.radius such that r = obj.radius
            % becomes a minimum
            R = obj.radius; 
            
            if( r < R )
                val = 1e3*exp( -(r/R)^2 );
            else
                val = 10*(r-(R+.3) )^2; % Initial value for potential
            end
            
        end% End center drone potential function
        
        
        %
        % Get potential if this drone is not a center drone
        %
        function val = GetOutsidePotential( obj, r  ) 
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
% End the drone class details
%
end
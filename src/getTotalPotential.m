function J = getTotalPotential( pos, drone_index, drone_array, obst_array , end_loc)
%
% pos               |  This is the position of the current drone that you
%                         want to find the potential for
%
% drone_index |  This is the index of the drone in the drone_array that you
%                          want to find the potential for
%
% drone_array  |  This is the array holding all the data for each drone
%
% obst_array    |  This is the array holding all the data for each obstacle
%
% end_loc         |  This is the end location for the center of the swarm




% Initialize the potential to zero
J = 0;

% Get the potential from the obstacles first
N_o = length(obst_array);

i = 1;
while( i <= N_o )
    J = J + obst_array(i).GetPotential( pos );
    i = i + 1;
end


% Check if this drone is the center or not
if( drone_array(drone_index).type <= 2 ) % This is an outside drone
    
    % Find the potential based on the drones
    N_d = length(drone_array);
    
    i = 1;
    while( i <= N_d )
        if( i ~= drone_index)
           J = J + drone_array(i).GetPotential( pos );
        end
        
        i = i + 1;
    end
    
    J = J + FinalLocationPotential( pos, end_loc);
    
else % This is a center drone
    
    % Find the potential based on the final location
    J = J + FinalLocationPotential( pos, end_loc);
    
end


end
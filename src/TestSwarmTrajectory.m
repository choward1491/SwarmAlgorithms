%Test Swarm Trajectory
clear all;

%Setup the movie stuff
make_movie = 1;
writerObj = [];
if( make_movie )
    writerObj = VideoWriter('test0.avi');
    writerObj.FrameRate = 15;
    open(writerObj);
end

% Parameter specifications for drones
Nd = 1+50;                    % number of drones
ind_c = -1;                       % index for lead/center drone
radius = 1;                     % radius for drones and possibl obstacles
dims = [0, 100; 0, 100]; % the x and y dimensions for the domain
xc = [80,80]';                 % initial location for center/lead drone
end_loc = [5,5]';            % desired final location for drone to go towards


% Parameter specifications for the obstacles
No = 10;
i = 1;
obst = [];
dims_o = [0, 20; 0, 20];
while( i <= No ) % randomly initialize location of obstacles and generate obstacle array
    pos = rand(2,1).*( dims_o(:,2)-dims_o(:,1) ) + dims_o(:,1);
    obst = [obst, Obstacle(pos,radius)];
    i = i + 1;
end


% Create drones and obstacle arrays
i = 1;
drones = [];
while( i <= Nd )
    if( i == ind_c ) % add lead drone to drone array
        drones = [drones, Drone(radius, xc , 2)];
    else
        % randomly generate position of follower drones based on location
        % of center/lead drone
        DEL = [xc - 10, xc + 10];
        pos = rand(2,1).*( DEL(:,2)-DEL(:,1) ) + DEL(:,1);
        
        % Add follower drone to drone array
        drones = [drones, Drone(radius, pos, 1)];
    end
    i = i + 1;
end

% Start updating the drones
close all;
h = figure('Position', [10, 10, 800, 400]);

% Do the initial drawing
i = 1;
hold on
while( i <=Nd ) % loop through the drones
    drawObject(drones(i));
    i = i + 1;
end

i = 1;
while( i <= No ) % loop through the obstacles
    drawObject(obst(i));
    i = i + 1;
end
hold off
axis([ dims(1,1),dims(1,2),dims(2,1),dims(2,2) ])


% Do iterations
it = 1;
count = 0;
done = 0;
while( done == 0 )
    i = 1;
    
    % Compute new locations
    while( i <= Nd )
        
        %specify doing PSO around a 1 unit box around the ith drone
        dims_span = [drones(i).pos - 1, drones(i).pos + 1];
        
        % Do the PSO optimziation
        [xb, Jb ] = SwarmAlgorithm(dims_span, @(x) getTotalPotential( x, i, drones, obst ,end_loc ) , 10, 1);
        
        % Find the cost at the current drone's position
        Jt = getTotalPotential( drones(i).pos, i, drones, obst, end_loc );
        
        if( Jb < Jt ) % if best PSO point is better than current location, update to new location
            drones(i).pos = xb;
            if( i == ind_c)
                count = 0;
            end
        else
            if( i == ind_c) % If the center drone isn't moving, add one to the counter
                count = count + 1;
            end
            
            if( count > 20 || it > 200 ) % if the center drone hasn't moved for more than 20 iterations, end the simulation
                done = 1;
            end
        end
        i = i + 1;
    end
    
    % Draw drones in new position
    i = 1;
    clf(h)
    hold on
    while( i <= Nd ) % loop through drones
        drawObject(drones(i));
        i = i + 1;
    end
    
    i = 1;
    while( i <= No ) % loop through obstacles
        drawObject(obst(i));
        i = i + 1;
    end
    hold off
    axis([ dims(1,1),dims(1,2),dims(2,1),dims(2,2) ])
    pause(.01)
    
    % Add frame to movie, if you are filming
    if( make_movie )
        frame = getframe;
        writeVideo(writerObj,frame);
    end
    
    it = it + 1;
end

% Close movie if you are filming
if( make_movie )
    close(writerObj);
end
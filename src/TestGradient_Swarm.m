%Test Swarm Trajectory
clear all;
false = 0;
true = 1;

%Setup the movie stuff
make_movie = false;
writerObj = [];
if( make_movie )
    writerObj = VideoWriter('test_gradient0.avi');
    writerObj.FrameRate = 15;
    open(writerObj);
end

% Parameter specifications for drones
Nd = 1+50;                    % number of drones in swarm
ind_c = -1;                       % index for center/lead drone
radius = 2;                     % radius for drones and possibly obstacles
dims = [0, 100; 0, 100; 0, 100]; % first row is lower and upper x bounds
                                                  % second row is lower and upper y bounds
                                                  % third row is lower and upper z bounds
xc = [80,80]'; % initial location for central/lead drone
end_loc = [5,5]';

% Parameter specifications for the obstacles
No = 10;
i = 1;
obst = [];
dims_o = [0, 20; 0, 20]; % first row is lower and upper x bounds
                                      % second row is lower and upper y bounds
while( i <= No )
    %randomly generate position of obstacle within bounds
    pos = rand(2,1).*( dims_o(:,2)-dims_o(:,1) ) + dims_o(:,1);
    
    % Add new obstacle to obstacle array obst
    obst = [obst, Obstacle(pos,radius)];
    i = i + 1;
end


% Create drones and obstacle arrays
i = 1;
drones = [];
while( i <= Nd )
    if( i == ind_c )
        % Add lead drone to drone array
        drones = [drones, Drone(radius, xc , 2)];
    else
        % Add a follower drone to drone array
        DEL = [xc - 10, xc + 10]; % make swarm initialize around lead drone randomly
        pos = rand(2,1).*( DEL(:,2)-DEL(:,1) ) + DEL(:,1);
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
while( i <=Nd ) % loop through drones
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
xpos = [];

% Do iterations
it = 1;
count = 0;
done = 0;
while( done == 0 )
    i = 1;
    
    % Compute new locations
    while( i <= Nd )
        drones(i).pos = drones(i).pos + GradientDescentUpdate(drones(i).pos, i, drones, obst, end_loc);

        if( count > 20 || it >= 200 )
            done = 1;
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
    
    % Add frame to movie, if you are wanting to make the movie
    if( make_movie )
        frame = getframe;
        writeVideo(writerObj,frame);
    end
    
    it = it + 1;
end

% Close movie file, if you are recording a movie
if( make_movie )
    close(writerObj);
end
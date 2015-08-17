function drawObject( object )

    color = 'k'; % Color to fill the object with 

    if( object.dim == 2 )
        if( isa(object,'Obstacle') ) %Check if the object is an obstacle
            color = 'r';
            
        else % else the object is a drone
            if( object.type == 1 )
                color = 'g';
            else
                color = 'b';
            end% end type if
            
        end% end dim if
         
        plot(object.pos(1), object.pos(2), '.', 'MarkerFaceColor', color, ...
                                                             'MarkerEdgeColor',color, ...
                                                             'MarkerSize', 10 )
        
        
    elseif( object.dim == 3 )
            [X,Y,Z] = sphere(16);
            [row,col] = size(X);
            c = zeros(row,col,3);
            pos = object.pos;
            r = object.radius/3;
            
            if( isa(object,'Obstacle') )
                c(:,:,1) = 1;
            else
                c(:,:,2) = 1;
            end
            
            surf(r.*X + pos(1), r.*Y + pos(2), r.*Z + pos(3), c );
            light('Position',[80, 0, 80]);
            h = findobj('Type','surface');
            set(h,'FaceLighting','gouraud',...
                      'FaceColor','interp',...
                      'EdgeColor',[.4 .4 .4],...
                      'LineStyle','none',...
                      'BackFaceLighting','lit',...
                      'AmbientStrength',0.4,...
                      'DiffuseStrength',0.6,...
                      'SpecularStrength',0.5);
    end

end
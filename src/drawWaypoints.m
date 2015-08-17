function drawWaypoints( wpt )

    color = 'k'; % Color to fill the object with 
    dim = length(wpt.queue.items(1).d);
    if( dim == 2 )
        color = 'b';
        
        for k = 1:wpt.queue.count
                pos = wpt.queue.items(k).d;
                plot(pos(1), pos(2), '.', 'MarkerFaceColor', color, ...
                                                             'MarkerEdgeColor',color, ...
                                                             'MarkerSize', 10 )
        end
        
        
    elseif( dim == 3 )
            [X,Y,Z] = sphere(16);
            [row,col] = size(X);
            c = zeros(row,col,3);
            r = .5;
            
            c(:,:,3) = 1;
            for k = 1:wpt.queue.count
                pos = wpt.queue.items(k).d;
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

end
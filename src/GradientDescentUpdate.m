function dx = GradientDescentUpdate(pos, drone_index, drones, obst, end_loc)
        dim = length(pos);
        arr = [1e-1, 1e-2, 1e-3, 1e-4];

        Jx = 0; Jy = 0; Jz = 0; J = 0; grad = zeros(dim,1);
        
        % Check how many dimensions in this problem and find gradient based
        % on that
        if( dim == 2 )
            Jx = getTotalPotential( pos+1e-4*[1;0], drone_index, drones, obst, end_loc ); % J(x + eps*e1)
            Jy = getTotalPotential( pos+1e-4*[0;1], drone_index, drones, obst, end_loc ); % J(x + eps*e2)
            J = getTotalPotential( pos, drone_index, drones, obst, end_loc );                      % J(x)

            dJdx = (Jx-J)/1e-4; %Get derivative with respect to each dimension
            dJdy = (Jy-J)/1e-4;
            grad = [dJdx, dJdy]';
        else
            Jx = getTotalPotential( pos+1e-4*[1;0;0], drone_index, drones, obst, end_loc ); % J(x + eps*e1)
            Jy = getTotalPotential( pos+1e-4*[0;1;0], drone_index, drones, obst, end_loc ); % J(x + eps*e2)
            Jz = getTotalPotential( pos+1e-4*[0;0;1], drone_index, drones, obst, end_loc ); % J(x + eps*e2)
            J = getTotalPotential( pos, drone_index, drones, obst, end_loc );                      % J(x)

            dJdx = (Jx-J)/1e-4; %Get derivative with respect to each dimension
            dJdy = (Jy-J)/1e-4;
            dJdz = (Jz-J)/1e-4;
            grad = [dJdx, dJdy, dJdz]';
        end
        
        % Find the magnitude of the gradient
        mag = sqrt(dot(grad,grad));
        
        % Find the unit vector of the gradient
        u = grad./mag;
        
        % Cap the speed of descent to 10
        if( mag >= 10 ) 
            mag = 10;
        end
        
        Jtmp = J;
        ind_p = 1;
        
        if( mag ~= 0 ) % If the magnitude is nonzero, find the nonzero update vector
            p = 1;
            
            % Find the optimal step size
            while( p <= length(arr) )
                dp = pos - arr(p)*u*mag;
                J0 = getTotalPotential( dp , drone_index, drones, obst, end_loc );
                if( J0< Jtmp )
                    Jtmp = J0;
                    ind_p = p;
                end
                p = p + 1;
            end
            
            %Create the optimal update vector
            dx = -arr(ind_p)*u*mag;
            
        else% If the gradient magnitude is zero, don't update the vector
            dx = u.*0;
        end
        
end% End of gradient descent update
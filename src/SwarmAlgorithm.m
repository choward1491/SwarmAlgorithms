function [x_best, J_best, swarm] = SwarmAlgorithm( dims_span, cost_func, num_swarm, num_iters )
    [r,c] = size(dims_span);
    N = r;
    
    % Initialize the Swarm
    i = 1;
    swarm = [];
    dd = dims_span(:,2) - dims_span(:,1);
    while( i <= num_swarm )
        swarm(i).x = rand(r,1).*dd + dims_span(:,1);
        swarm(i).J = 0;
        i = i + 1;
    end
    
    % Do the optimization iterations
    x_best = [];
    J_best = 1e50;
    J = 0;
    it = 0;
    
    while( it <= num_iters )
        Jb = 1e50;
        sb = 0;
        
        % Evaluate the Swarm Cost
        s = 1;
        while( s <= num_swarm )
            J = cost_func( swarm(s).x );
            swarm(s).J = J;
            
            if( J < Jb )
                Jb = J;
                sb = s;
                
                if( J < J_best )
                    J_best = J;
                    x_best = swarm(s).x;
                    
                end% End J_best if
            end% End Jb if
            
            s = s + 1;
        end% End computing costs of swarm particles
        
        % Update locations based on best value
        s = 1;
        while( s <= num_swarm )
            if( s ~= sb )
                del = swarm(sb).x - swarm(s).x;
                coef = (swarm(s).J - swarm(sb).J )/swarm(sb).J;
                coef = .1*max(1,1./(1+exp(-coef) ) );
                swarm(s).x = swarm(s).x + coef.*del;
            end
            
            s = s + 1;
        end% End updating swarm
        
        it = it + 1;
    end% End iteration loop
    


end% End Swarm Algorithm
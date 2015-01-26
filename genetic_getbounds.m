function [ result ] = genetic_getbounds( command )
%GENETIC_GETBOUNDS Get the bounds of the genetic search algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)

    opt_bounds = [  ...
                10 400 1; ...             %(1)window_size
                0.0001 10 0; ...          %(2)ridge_coeff
                2 150 1; ...              %(3)num_expertevaluators 
                200 4000 1; ...           %(4)maxlag_timehorizon (check selection)
                1 10 1; ...               %(5)degree
                0 1 0 ...                 %(6)alpha (depends on number of experts)
                ]; 
    
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


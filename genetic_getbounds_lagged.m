function [ result ] = genetic_getbounds_lagged( command )
%GENETIC_GETBOUNDS Get the bounds of the genetic search algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)

    opt_bounds = [  ...
                10 250 1; ...              %(1)window_size
                0.01 10 0; ...          %(2)ridge_coeff
                10 100 1; ...             %(3)num_expertevaluators 
                200 1000 1; ...            %(4)maxlag_timehorizon (check selection)
                1 10 1; ...               %(5)degree
                0 1 0; ...                %(6)alpha
                ]; 
    
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


function [ result ] = genetic_getbounds( command )
%GENETIC_GETBOUNDS Get the bounds of the genetic search algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)

    opt_bounds = [  ...
                10 400 1; ...             %window_size
                0.0001 10 0; ...          %ridge_coeff
                2 150 1; ...              %num_expertevaluators 
                0 4000 1; ...             %maxlag_timehorizon (check selection)
                1 10 1; ...               %degree
                0 1 0 ...                 %alpha (depends on number of experts)
                ]; 
    
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


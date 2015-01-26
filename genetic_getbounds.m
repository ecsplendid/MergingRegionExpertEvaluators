function [ result ] = genetic_getbounds( command )
%GENETIC_GETBOUNDS Get the bounds of the genetic search algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)

    opt_bounds = [  ...
                10 400 1; ...             %window_size
                0.001 10 0; ...           %ridge_coeff
                1 100 1; ...              %num_expertevaluators
                0 5000 1; ...             %maxlag_timehorizon
                1 8 1; ...                %degree
                0 2 1 ...                 %alpha
                ]; 
      
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


function [ result ] = genetic_getbounds_randommerged( command )
%genetic_getbounds_randommerged Get the bounds of the genetic search algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)


    opt_bounds = [  ...
                5 250 1; ...            %(1)num_expertevaluators
                5 40 1; ...             %(2)stack_count
                0 1 0; ...              %(3)alpha
                ]; 
    
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


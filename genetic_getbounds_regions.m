function [ result ] = genetic_getbounds_regions( command )
%genetic_getbounds_regions Get the bounds of the genetic search algorithm
%for the merging fixed regions algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)

    opt_bounds = [  ...
                30 300 1; ...             %(1)window_size
                0.1 10 0; ...             %(2)ridge_coeff
                10 500 1; ...             %(3)num_expertevaluators
                1 10 1; ...               %(4)degree
                0 1 0; ...                %(5)alpha
                ]; 
    
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


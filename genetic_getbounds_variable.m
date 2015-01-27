function [ result ] = genetic_getbounds_variable( command )
%GENETIC_GETBOUNDS Get the bounds of the genetic search algorithm
%command (1==lower bounds) (2==upperbounds) (-1==integers)


    opt_bounds = [  ...
                100 500 1; ...            %(1)window_size
                0.01 10 0; ...            %(2)ridge_coeff
                5 50 1; ...               %(3)num_expertevaluators 
                1 10 1; ...               %(4)degree
                0 1 0; ...                %(5)alpha
                20 99 1; ...              %(6)window_sizeminimum 
                ]; 
    
    if command == 1
        result = opt_bounds(:,1);
    elseif command==2
        result = opt_bounds(:,2);
    elseif command == -1
        result = find(opt_bounds(:,3)==1);
    end
end


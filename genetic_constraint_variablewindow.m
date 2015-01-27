function [c, ceq] = genetic_constraint_variablewindow( x )
%GENETIC_CONSTRAINT_VARIABLEWINDOW basic contraint on variable window
%genetic search problem, the minimum window size has to be smaller than the
%window_size

%x(1)==window_size
%x(4)==window_sizeminimum
%x(4)<x(1)
              
    ceq = [];
    
    c = x;
    c(1) = max( x(4), x(1) );
    c(4) = min( x(4), x(1) );
              
end


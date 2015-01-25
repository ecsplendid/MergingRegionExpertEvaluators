function [ best_params ] = genetic_optimizeridgeregression( )
%GENETIC_OPTIMIZERIDGEREGRESSION figure out the best parameters for ridge
%regression on the validation set (rts1206)
%%

options = gaoptimset;
options = gaoptimset(options,'PopulationSize', [ 100 ] );
options = gaoptimset(options,'MigrationDirection', 'both');
options = gaoptimset(options,'MigrationInterval', 3);
options = gaoptimset(options,'MigrationFraction', 0.3);
options = gaoptimset(options,'EliteCount', 7);
options = gaoptimset(options,'CrossoverFraction', 0.5);
options = gaoptimset(options,'Generations', 10);
options = gaoptimset(options,'StallGenLimit', 5);
options = gaoptimset(options,'Display', 'iter');
options = gaoptimset(options,'PlotFcns', {  ...
    @gaplotbestf @gaplotbestindiv @gaplotdistance ...
    @gaplotexpectation @gaplotrange ...
    @gaplotscorediversity @gaplotscores @gaplotselection...
    @gaplotstopping @gaplotmaxconstr });
options = gaoptimset(options,'Vectorized', 'off');
options = gaoptimset(options,'UseParallel', 1 );

best_params = ga( @genetic_optimizeridgeevaluator, ...
    3, ... % num constraints
    [],[],[],[], ...
    [1 1 0.0001], ... % lower
    [12 450 10], ... % upper
    [], ...
    [1 2], ... % int constraints
    options );

end


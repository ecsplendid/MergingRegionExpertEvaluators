function [ best_params ] = genetic_optimizeridgeregression( ...
    function_evaluator, genetic_model )
%GENETIC_OPTIMIZERIDGEREGRESSION figure out the best parameters for ridge
% the evaulation set is set inside the nested argument function_evaluator
% from caller. For brevity this just returns the best_params directly, it's
% reasonably clear that its structure is [ degree, window, ridge ]
%%
diary on;

options = gaoptimset;
options = gaoptimset(options,'PopulationSize', genetic_model.PopulationSize );
options = gaoptimset(options,'MigrationDirection', genetic_model.MigrationDirection);
options = gaoptimset(options,'MigrationInterval', genetic_model.MigrationInterval);
options = gaoptimset(options,'MigrationFraction', genetic_model.MigrationFraction);
options = gaoptimset(options,'EliteCount', genetic_model.EliteCount);
options = gaoptimset(options,'CrossoverFraction', genetic_model.CrossoverFraction);
options = gaoptimset(options,'Generations', genetic_model.Generations);
options = gaoptimset(options,'StallGenLimit', genetic_model.StallGenLimit);
options = gaoptimset(options,'Display', 'iter');
options = gaoptimset(options,'Display', 'iter');
options = gaoptimset(options,'PlotFcns', {  ...
    @gaplotbestf @gaplotbestindiv @gaplotdistance ...
    @gaplotexpectation @gaplotrange ...
    @gaplotscorediversity @gaplotscores @gaplotselection...
    @gaplotstopping @gaplotmaxconstr });
options = gaoptimset(options,'Vectorized', 'off');
options = gaoptimset(options,'UseParallel', 1 );

% note that the bounds for this problem are encoded in-place below
% i.e. lower(degree=1,windowsize=20, ridge=0.0001)
% upper(degree=10,windowsize=450, ridge=10)
best_params = ga( function_evaluator, ...
    3, ... % num constraints
    [],[],[],[], ...
    [1 20 0.0001], ...      % lower
    [10 450 10], ...        % upper
    [], ...
    [1 2], ...              % int constraints
    options );

save( './Models/best_params_ridgesimple.mat' , 'best_params' );
saveas(gcf, './Models/best_params_ridgesimple.fig' );

diary off;

end


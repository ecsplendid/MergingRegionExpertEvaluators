function [ model ] = genetic_optimizeparams( ...
    optimization_function, description, genetic_model  )
%GENETIC_OPTIMIZEPARAMS Find the best set of parameters to fit a model
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
options = gaoptimset(options,'PlotFcns', {  ...
    @gaplotbestf @gaplotbestindiv @gaplotdistance ...
    @gaplotexpectation @gaplotrange ...
    @gaplotscorediversity @gaplotscores @gaplotselection...
    @gaplotstopping @gaplotmaxconstr });
options = gaoptimset(options,'Vectorized', 'off');
options = gaoptimset(options,'UseParallel', 1 );

best_params = ga( optimization_function, ...
    length(genetic_getbounds( 1 )), ... % num constraints
    [],[],[],[], ...
    genetic_getbounds( 1 ), ...     % lower
    genetic_getbounds( 2 ), ...     % upper
    [], ...
    genetic_getbounds( -1 ), ...    % int constraints
    options );

% save files
save( sprintf( './Models/best_params_%s.mat', description ), 'best_params' );
saveas(gcf,sprintf( './Models/best_params_%s.fig', description ));
model = model_getfromvector(best_params)
model.genetic_model = genetic_model;
save( sprintf( './Models/best_model_%s.mat', description ), 'model' );

diary off;

end
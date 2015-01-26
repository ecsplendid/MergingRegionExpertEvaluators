function [ model ] = genetic_optimizeparams( )
%GENETIC_OPTIMIZEPARAMS Find the best set of parameters to fit a model
%%
diary on;

options = gaoptimset;
options = gaoptimset(options,'PopulationSize', [ 80 ] );
options = gaoptimset(options,'MigrationDirection', 'both');
options = gaoptimset(options,'MigrationInterval', 3);
options = gaoptimset(options,'MigrationFraction', 0.3);
options = gaoptimset(options,'EliteCount', 5);
options = gaoptimset(options,'CrossoverFraction', 0.5);
options = gaoptimset(options,'Generations', 30);
options = gaoptimset(options,'StallGenLimit', 5);
options = gaoptimset(options,'Display', 'iter');
options = gaoptimset(options,'PlotFcns', {  ...
    @gaplotbestf @gaplotbestindiv @gaplotdistance ...
    @gaplotexpectation @gaplotrange ...
    @gaplotscorediversity @gaplotscores @gaplotselection...
    @gaplotstopping @gaplotmaxconstr });
options = gaoptimset(options,'Vectorized', 'off');
options = gaoptimset(options,'UseParallel', 1 );

global global_aamode;
global_aamode = 2;
% variable share

best_params = ga( @genetic_optimizationevaluator_lagged, ...
    length(genetic_getbounds( 1 )), ... % num constraints
    [],[],[],[], ...
    genetic_getbounds( 1 ), ... % lower
    genetic_getbounds( 2 ), ... % upper
    [], ...
    genetic_getbounds( -1 ), ... % int constraints
    options );

save( 'best_params_vs.mat', 'best_params' );
saveas(gcf,'best_vs.fig');
model = model_getfromvector(best_params)
save( 'best_vs.mat', 'model' );

global_aamode = 1;
% variable share

best_params = ga( @genetic_optimizationevaluator_lagged, ...
    length(genetic_getbounds( 1 )), ... % num constraints
    [],[],[],[], ...
    genetic_getbounds( 1 ), ... % lower
    genetic_getbounds( 2 ), ... % upper
    [], ...
    genetic_getbounds( -1 ), ... % int constraints
    options );

save( 'best_params_fs.mat', 'best_params' );
saveas(gcf,'best_fs.fig');
model = model_getfromvector(best_params)
save( 'best_fs.mat', 'model' );

global_aamode = 0;
% variable share

best_params = ga( @genetic_optimizationevaluator_lagged, ...
    length(genetic_getbounds( 1 )), ... % num constraints
    [],[],[],[], ...
    genetic_getbounds( 1 ), ... % lower
    genetic_getbounds( 2 ), ... % upper
    [], ...
    genetic_getbounds( -1 ), ... % int constraints
    options );

save( 'best_params_sl.mat', 'best_params' );
saveas(gcf,'best_sl.fig');
model = model_getfromvector(best_params)
save( 'best_sl.mat', 'model' );

end
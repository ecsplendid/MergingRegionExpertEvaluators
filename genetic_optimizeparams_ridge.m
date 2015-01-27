function [ model ] = genetic_optimizeparams_ridge( ...
    function_evaluator, genetic_model )
%GENETIC_OPTIMIZERIDGEREGRESSION figure out the best parameters for ridge
% the evaulation set is set inside the nested argument function_evaluator
% from caller. For brevity this just returns the best_params directly, it's
% reasonably clear that its structure is [ degree, window, ridge ]
%%
diary on;
options = genetic_getgaoptimset( genetic_model );

% note that the bounds for this problem are encoded in-place below
% i.e. lower(degree=1,windowsize=20, ridge=0.0001)
% upper(degree=10,windowsize=450, ridge=10)
best_params = ga( function_evaluator, ...
    3, ... % num constraints
    [],[],[],[], ...
    [1 20 0.0001], ...      % lower
    [10 500 10], ...       % upper
    [], ...
    [1 2], ...              % int constraints
    options );

saveas(gcf, './Models/best_params_ridgesimple.fig' );

model = region_model();
model.degree = best_params(1);
model.window_size = best_params(2);
model.ridge_coeff = best_params(3);

save( './Models/best_model_ridgesimple.mat' , 'model' );

diary off;

end


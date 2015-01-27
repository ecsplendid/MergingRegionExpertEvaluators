function [ best_params ] = genetic_optimizeparams_variable( ...
    function_evaluator, description, genetic_model )
%GENETIC_OPTIMIZERIDGEREGRESSION figure out the best parameters for ridge
% the evaulation set is set inside the nested argument function_evaluator
% from caller. For brevity this just returns the best_params directly, it's
% reasonably clear that its structure is [ degree, window, ridge ]
%%
diary on;

options = genetic_getgaoptimset( genetic_model );

best_params = ga( optimization_function, ...
    length(genetic_getbounds_variable( 1 )), ... % num constraints
    [],[],[],[], ...
    genetic_getbounds_variable( 1 ), ...     % lower
    genetic_getbounds_variable( 2 ), ...     % upper
    [], ...
    genetic_getbounds_variable( -1 ), ...    % int constraints
    options );

% save files
save( sprintf( './Models/best_params_%s.mat', description ), 'best_params' );
saveas(gcf,sprintf( './Models/best_params_%s.fig', description ));
model = model_getfromvector_variable(best_params)
model.genetic_model = genetic_model;
save( sprintf( './Models/best_model_%s.mat', description ), 'model' );

diary off;

end


function [ model ] = genetic_optimizeparams_metamerged( ...
    optimization_function, description, genetic_model  )
%genetic_optimizeparams_metamerged Find the best set of parameters to fit a 
% meta merged model
%%
diary on;

options = genetic_getgaoptimset( genetic_model );

best_params = ga( optimization_function, ...
    length(genetic_getbounds_metamerged( 1 )), ... % num constraints
    [],[],[],[], ...
    genetic_getbounds_metamerged( 1 ), ...     % lower
    genetic_getbounds_metamerged( 2 ), ...     % upper
    [], ...
    genetic_getbounds_metamerged( -1 ), ...    % int constraints
    options );

% save files
save( sprintf( './Models/best_params_%s.mat', description ), 'best_params' );
saveas(gcf,sprintf( './Models/best_params_%s.fig', description ));
model = model_getfromvector_metamerged(best_params)
model.genetic_model = genetic_model;
save( sprintf( './Models/best_model_%s.mat', description ), 'model' );

diary off;

end
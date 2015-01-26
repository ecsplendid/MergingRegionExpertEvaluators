function [ preds, losses ] = regression_onlinevariablewindows( ...
    corpus, labels, kernel, ...
    window_size, ridge_coeff, window_sizeminimum, ...
    num_expertevaluators )
%REGRESSION_ONLINEVARIABLEWINDOWS will produce a matrix of num_expertevaluator
%sliding window ridge regression predictors of sizes varying from 
%window_sizeminimum to window_size. Will start predicting from
%window_size+1

preds = nan( size(corpus,2), num_expertevaluators );
losses = nan( size(corpus,2), num_expertevaluators );

window_sizes = floor( ...
                linspace( ...
                    window_sizeminimum, ...
                    window_size, ...
                    num_expertevaluators ...
                    ) );

for e=1:num_expertevaluators
    
    [P, L] = regression_basic...
        ( corpus, labels, kernel, window_sizes(e), ridge_coeff );

    preds( window_sizes(e)+1:end, e ) = P;
    losses( window_sizes(e)+1:end, e ) = L;

end

end


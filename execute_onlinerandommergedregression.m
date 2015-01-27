function [ model ] = execute_onlinerandommergedregression( ...
    model, pred_matrix )
%execute_onlinerandommergedregression execute the random merged regression
%algorithm 
%pred_matrix: pass in a pre-computed predmatrix

tic;

[corpus, labels, competitor] = ...
    get_corpus( model.corpus_name, model.selection );

if nargin < 2
    [pred_matrix, ~] = regression_onlinerandomparams...
        ( corpus, labels, ...
        model.window_sizes, model.ridges, model.degrees, ...
        model.num_expertevaluators );
end

last_nan = max(find(isnan(pred_matrix(:,1))));

% we don't issue predictions for 1:window_size as there is no fallback
% predictor (see thesis)
pred_matrix_truncated = pred_matrix((last_nan+1):end,:);
labels_truncated = labels(last_nan+1:end);

[L, P, weights] = merge_expertevaluators( pred_matrix_truncated, ...
        labels_truncated, model.alpha, model.AA_mode);
        
volatility= labels';
model.complosses = (competitor - volatility).^2;
model.loss = L;
model.adjusted_loss = (L - model.complosses( (last_nan+1):end)' );
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels_truncated;
model.weights = weights;
model.predictions = P;
model.pred_matrix = pred_matrix;

end

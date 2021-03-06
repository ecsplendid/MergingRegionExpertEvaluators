function [ model ] = execute_onlinefixedregions( model )

tic;

[corpus, labels, competitor] = ...
    get_corpus( model.corpus_name, model.selection );

kernel = @(X,y) kernel_polynomial(X,y,model.degree);
window_size = model.window_size;

[pred_matrix, ~] = regression_onlinefixedregions...
    ( corpus, labels, kernel, window_size, model.ridge_coeff, ...
    model.num_expertevaluators );

% we don't issue predictions for 1:window_size as there is no fallback
% predictor (see thesis)
pred_matrix_truncated = pred_matrix((window_size+1):end,:);
labels_truncated = labels(window_size+1:end);

[L, P, weights] = merge_expertevaluators( pred_matrix_truncated, ...
        labels_truncated, model.alpha, model.AA_mode);
        
model.complosses = (competitor((window_size+1):end)...
    - labels((window_size+1):end)').^2;
model.adjusted_loss = L' - model.complosses;
model.loss = L;
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels_truncated;
model.weights = weights;
model.predictions = P;

end

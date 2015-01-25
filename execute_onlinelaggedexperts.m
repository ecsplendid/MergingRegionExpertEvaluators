function [ model ] = execute_onlinelaggedexperts( model )

tic;

[corpus, labels, competitor] = get_corpus( model.corpus_name, model.truncate );

kernel = @(X,y) kernel_polynomial(X,y,model.degree);
window_size = model.window_size;

[pred_matrix, ~] = regression_onlinelaggedexperts...
    ( corpus, labels, kernel, window_size, model.ridge_coeff, ...
    model.num_expertevaulators, model.maxlag_timehorizon );

% we don't issue predictions for 1:window_size as there is no fallback
% predictor (see thesis)
pred_matrix_truncated = pred_matrix((window_size+1):end,:);
labels_truncated = labels(window_size+1:end);

[L, P, weights] = merge_expertevaluators( pred_matrix_truncated, ...
        labels_truncated, model.alpha, model.AA_mode);
        
volatility= labels';
model.complosses = (competitor - volatility).^2;
model.loss = L;
model.adjusted_loss = (L - model.complosses( (window_size+1):end)' );
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels_truncated;
model.weights = weights;
model.predictions = P;

end

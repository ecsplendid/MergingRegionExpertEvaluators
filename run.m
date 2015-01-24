corpus_name = 'eeru1206';
[corpus, labels, competitor] = get_corpus( corpus_name );

degree = 4;
kernel = @(X,y) kernel_polynomial(X,y,degree);
window_size = 150;
ridge_coeff = 0.1;
num_expertevaulators = 10;
maxlag_timehorizon = 0;
AA_mode = 2;
alpha = 0.999;

[pred_matrix, ~] = regression_regionevaluators...
    ( corpus, labels, kernel, window_size, ridge_coeff, ...
    num_expertevaulators, maxlag_timehorizon );

% we don't issue predictions for 1:window_size as there is no fallback
% predictor (see thesis)
pred_matrix_truncated = pred_matrix((window_size+1):end,:);
labels_truncated = labels(window_size+1:end);

[L, P, weights] = merge_expertevaluators( pred_matrix_truncated, ...
        labels_truncated, alpha, AA_mode);
        
volatility= labels';

complosses = (competitor - volatility).^2;
adjusted_loss = (L - complosses( (window_size+1):end)' );
cums = cumsum(adjusted_loss);

plot(cums)
title(corpus_name)
grid on;

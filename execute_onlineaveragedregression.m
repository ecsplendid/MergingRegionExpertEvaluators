function [ model ] = execute_onlineaveragedregression( ...
    model, pred_matrix )
%execute_onlineaveragedregression take a prediction matrix and return the
%mean average for all records

tic;

[~, labels, competitor] = ...
    get_corpus( model.corpus_name, model.selection );

last_nan = max(find(isnan(pred_matrix(:,1))));

% we don't issue predictions for 1:window_size as there is no fallback
% predictor (see thesis)
pred_matrix_truncated = pred_matrix((last_nan+1):end,:);
labels_truncated = labels(last_nan+1:end);

P = nanmean( pred_matrix_truncated, 2 );

volatility= labels';

L = (P - volatility((last_nan+1):end)).^2;

model.complosses = (competitor - volatility).^2;
model.loss = L;
model.adjusted_loss = (L - model.complosses( (last_nan+1):end) );
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels_truncated;
model.predictions = P;
model.pred_matrix = pred_matrix;

end

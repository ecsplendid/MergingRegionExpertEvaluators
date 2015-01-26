function [ model ] = execute_onlinebasicregression( model )

tic;
[corpus, labels, competitor] = get_corpus( ...
    model.corpus_name, model.selection );

kernel = @(X,y) kernel_polynomial(X,y,model.degree);
window_size = model.window_size;

[preds, loss] = regression_basic...
    ( corpus, labels, kernel, window_size, model.ridge_coeff );

% we don't issue predictions for 1:window_size as there is no fallback
% predictor (see thesis)
preds_truncated = preds((window_size+1):end);
labels_truncated = labels(window_size+1:end);

model.complosses = (competitor((window_size+1):end)...
    - labels((window_size+1):end)').^2;
model.adjusted_loss = loss - model.complosses;
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels_truncated;
model.pred_matrix = preds_truncated;
model.loss = loss;

end

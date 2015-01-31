function [ model ] = ...
execute_onlinemergedrandommergedregression...
    ( model, pred_matrix )
%execute_onlinemergedrandommergedregression calls
%execute_onlinerandommergedregression model.stack_count number of times
%the predictions from the merged algorithms are merged again.

[~, labels, competitor] = ...
    get_corpus( model.corpus_name, model.selection );

preds = zeros( length(labels), model.stack_count );

for i=1:model.stack_count

    [randmodel, first_prediction ] = ...
        execute_onlinerandommergedregression( model, pred_matrix );

        preds(first_prediction:end, i) = randmodel.predictions;
end

% Models start predicting from a random windowsize, all of which 
pred_matrix_truncated = preds((model.window_size+1):end,:);
labels_truncated = labels(model.window_size+1:end);

[L, P, weights] = merge_expertevaluators( pred_matrix_truncated, ...
        labels_truncated, model.alpha, model.AA_mode);

model.complosses = (competitor(model.window_size+1:end) - ...
    labels_truncated').^2;

model.loss = L;
model.adjusted_loss = L - model.complosses';
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels;
model.weights = weights;
model.predictions = P;
model.pred_matrix = pred_matrix;
model.results_adjustedlosssum = sum(model.adjusted_loss);
model.results_adjustedlossmedian = median(model.adjusted_losscs);
end



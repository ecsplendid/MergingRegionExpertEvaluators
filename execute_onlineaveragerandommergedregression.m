function [ model ] = execute_onlineaveragerandommergedregression...
    ( model, pred_matrix )
%EXECUTE_ONLINESTACKEDRANDOMMERGEDREGRESSION calls
%execute_onlinerandommergedregression model.stack_count number of times
%the predictions from the merged algorithms are averaged.

[~, labels, competitor] = ...
    get_corpus( model.corpus_name, model.selection );

preds = zeros( length(labels), model.stack_count );

for i=1:model.stack_count

    [randmodel, first_prediction ] = ...
        execute_onlinerandommergedregression( model, pred_matrix );

        preds(first_prediction:end, i) = randmodel.predictions;

end

% Models start predicting from a random windowsize, all of which 
% are less than 300
predict_from = 301;

model.complosses = (competitor(predict_from:end) - labels(predict_from:end)').^2;

P = mean(preds,2)';

L = (labels(predict_from:end) - P(predict_from:end)) .^ 2;

model.loss = L;
model.adjusted_loss = L - model.complosses';
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels;
%model.weights = weights;
model.predictions = P;
model.pred_matrix = pred_matrix;
model.results_adjustedlosssum = sum(model.adjusted_loss);
model.results_adjustedlossmedian = median(model.adjusted_losscs);
end


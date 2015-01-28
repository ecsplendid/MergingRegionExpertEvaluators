function [ model ] = execute_onlinepossiblelabels( ...
    model )
%execute_onlinelaggedexperts merges lagged labels from the recent past

tic;
[corpus, labels, competitor] = get_corpus( ...
    model.corpus_name, model.selection );


[pred_matrix] = regression_onlinepossiblelabels...
    ( corpus, model.num_expertevaluators, model.label_min, model.label_max );

[L, P, weights] = merge_expertevaluators( pred_matrix, ...
        labels, model.alpha, model.AA_mode);
        
model.complosses = (competitor...
    - labels').^2;
model.adjusted_loss = L' - model.complosses;
model.loss = L;
model.adjusted_losscs = cumsum(model.adjusted_loss);
model.execution_time = toc;
model.labels = labels;
model.weights = weights;
model.predictions = P;
model.pred_matrix = pred_matrix;

end

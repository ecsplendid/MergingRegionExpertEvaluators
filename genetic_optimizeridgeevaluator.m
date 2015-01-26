function [score] = genetic_optimizeridgeevaluator( ...
    opts, selection, corpus_name )

[corpus, labels, ~] = get_corpus( ...
    corpus_name, selection );

degree = opts(1);       % (1) integer {1,2,3,...,10}
window_size = opts(2);  % (2) integer {1,2,...,450}
a = opts(3);            % (3) not integer [0.0001,10]

kernel = @(X,y) kernel_polynomial(X,y,degree);

[~, losses] = regression_basic(...
    corpus, labels, kernel, window_size, a);

% we need to normalize by the number of predictions (take mean) given
% otherwise the loss would decrease with increasing window size
% because we start predicting on window_size + 1
score = mean( losses );

end
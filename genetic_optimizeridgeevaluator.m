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

score = sum(losses);

end
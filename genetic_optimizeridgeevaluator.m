function [score] = genetic_optimizeridgeevaluator( opts )

% 7.0000  261.0000    2.9117
corpus_name = 'rts1206';

[corpus, labels, ~] = get_corpus( corpus_name, 8000 );

degree = opts(1);       % (1) integer {1,2,3,...,10}
window_size = opts(2);  % (2) integer {1,2,...,450}
a = opts(3);            % (3) not integer [0.0001,10]

kernel = @(X,y) kernel_polynomial(X,y,degree);

[~, losses] = regression_basic(...
    corpus, labels, kernel, window_size, a);

score = sum(losses);

end
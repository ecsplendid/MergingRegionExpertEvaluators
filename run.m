

[corpus, labels] = get_corpus( 'eeru1206' );

degree = 4;
kernel = @(X,y) kernel_polynomial(X,y,degree);

window_size = 100;
ridge_coeff = 0.5;
num_expertevaulators = 5;
maxlag_timehorizon = 400;

[preds, losses] = regression_regionevaluators...
    ( corpus, labels, kernel, window_size, ridge_coeff, ...
    num_expertevaulators, maxlag_timehorizon )
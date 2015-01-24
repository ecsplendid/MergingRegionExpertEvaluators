

[corpus, labels] = get_corpus( 'eeru1206' );


%%

[preds, losses] = regression_regionevaluators...
    ( data, labels, kernel, window_size, ridge_coeff, ...
    num_expertevaulators, maxlag_timehorizon )
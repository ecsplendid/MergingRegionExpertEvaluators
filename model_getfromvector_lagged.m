function [ model ] = model_getfromvector_lagged( vector, corpus_name )
%MODEL_GETFROMVECTOR_lagged Get a model from a vector input

    model = region_model();
    model.window_size = vector(1);
    model.ridge_coeff = vector(2);
    model.num_expertevaluators = vector(3);
    model.maxlag_timehorizon = vector(4);
    model.degree = vector(5);
    model.alpha = vector(6);
    
    if nargin > 1
        model.corpus_name = corpus_name;
    end
end
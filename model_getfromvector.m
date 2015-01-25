function [ model ] = model_getfromvector( vector, corpus_name )
%MODEL_GETFROMVECTOR Get a model from a vector input

    model = region_model();
    model.window_size = vector(1);
    model.ridge_coeff = vector(2);
    model.num_expertevaulators = vector(3);
    model.maxlag_timehorizon = vector(4);
    model.alpha = vector(5);
    model.degree = vector(6);
    
    if nargin > 1
        model.corpus_name = corpus_name;
    end
end


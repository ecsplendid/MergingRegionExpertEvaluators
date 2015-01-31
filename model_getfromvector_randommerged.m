function [ model ] = model_getfromvector_randommerged( vector, corpus_name )
%MODEL_GETFROMVECTOR_lagged Get a model from a vector input

    model = region_model();
    model.num_expertevaluators = vector(1);
    model.stack_count = vector(2);
    model.alpha = vector(3);
    
    if nargin > 1
        model.corpus_name = corpus_name;
    end
end
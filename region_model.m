classdef region_model
    %region_model describes the key attributes for a regions algorithm
    %model
     
    properties
        corpus_name = 'eeru1206';
        degree = 4;
        kernel = @(X,y) kernel_polynomial(X,y,degree);
        window_size = 208;
        ridge_coeff = 0.1695;
        % note that if maxlag_timehorizon is too high 
        % you might get experts outputting NaN all the time
        num_expertevaluators = 47;
        AA_mode = 2;
        alpha = 0.543;
        adjusted_loss = [];
        adjusted_losscs = [];
        labels = [];
        execution_time;
        loss;
        complosses;
        predictions;
        selection = 1:7000; % selection of records (-1 for all)
        weights;
        % will have 1:windowsize cut off
        pred_matrix; 
        % only relevant for online lagged algorithm
        maxlag_timehorizon = 4380;
        % only relevant for variable merged window size algorithm
        window_sizeminimum = 50;
    end
    
    methods
    end
    
end


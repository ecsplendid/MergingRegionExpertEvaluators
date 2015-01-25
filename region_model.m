classdef region_model
    %region_model describes the key attributes for a regions algorithm
    %model
     
    properties
        corpus_name = 'eeru1206';
        degree = 7;
        kernel = @(X,y) kernel_polynomial(X,y,degree);
        window_size = 239;
        ridge_coeff = 2;
        % note that if maxlag_timehorizon is too high 
        % you might get experts outputting NaN all the time
        num_expertevaulators = 72;
        AA_mode = 2;
        alpha = 0.543;
        adjusted_loss = [];
        adjusted_losscs = [];
        labels = [];
        execution_time;
        loss
        complosses
        predictions
        truncate = -1 % truncate at this number of records i.e. 6000
        weights
        % only relevant for online lagged algorithm
        maxlag_timehorizon = 4380;
    end
    
    methods
    end
    
end


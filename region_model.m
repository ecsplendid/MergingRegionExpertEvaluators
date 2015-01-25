classdef region_model
    %region_model describes the key attributes for a regions algorithm
    %model
     
    properties
        corpus_name = 'eeru1206';
        degree = 6;
        kernel = @(X,y) kernel_polynomial(X,y,degree);
        window_size = 278;
        ridge_coeff = 0.6525;
        num_expertevaulators = 50;
        maxlag_timehorizon = 10000;
        AA_mode = 2;
        alpha = 0.4;
        adjusted_loss = [];
        adjusted_losscs = [];
        labels = [];
        execution_time;
        loss
        complosses
        predictions
        truncate = -1 % truncate at this number of records i.e. 6000
        weights
    end
    
    methods
    end
    
end


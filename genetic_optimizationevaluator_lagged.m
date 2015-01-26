function [ score ] = genetic_optimizationevaluator_lagged( modelvector )
%GENETIC_OPTIMIZATIONEVALUATOR the evaluation function for the genetic
%parameter search (will just take the sum of the loss, note that we intend 
%to truncate before the data goes crazy near maturity)

    %rts1206 is the validation set
    model = model_getfromvector(modelvector, 'rts1206');
    model.AA_mode = 0;
    model.selection = 4000:8000;
    model = regression_onlinelaggedexperts(model);
    score = model.adjusted_losscs(end);
    
end



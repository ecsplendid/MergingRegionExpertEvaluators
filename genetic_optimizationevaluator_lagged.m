function [ score ] = genetic_optimizationevaluator_lagged( modelvector )
%GENETIC_OPTIMIZATIONEVALUATOR the evaluation function for the genetic
%parameter search (will just take the sum of the loss, note that we intend 
%to truncate before the data goes crazy near maturity)

global global_aamode;

    %rts1206 is the validation set
    model = model_getfromvector(modelvector, 'rts1206');
    model.AA_mode = global_aamode;
    model.selection = 5000:8000;
    model = execute_onlinelaggedexperts(model);
    score = model.adjusted_losscs(end);
    
end



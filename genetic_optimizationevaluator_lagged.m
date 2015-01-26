function [ score ] = genetic_optimizationevaluator_lagged( ...
    modelvector, corpus_name, aa_mode, selection )
%GENETIC_OPTIMIZATIONEVALUATOR the evaluation function for the genetic
%parameter search (will just take the sum of the loss, note that we intend 
%to truncate before the data goes crazy near maturity)

    %rts1206 is the validation set
    model = model_getfromvector(modelvector, corpus_name);
    model.AA_mode = aa_mode;
    model.selection = selection;
    model = execute_onlinelaggedexperts(model);
    score = model.adjusted_losscs(end);

end



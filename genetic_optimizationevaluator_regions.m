function [ score ] = genetic_optimizationevaluator_regions( ...
    modelvector, corpus_name, aa_mode, selection )
%GENETIC_OPTIMIZATIONEVALUATOR the evaluation function for the genetic
%parameter search 

    %rts1206 is the validation set
    model = model_getfromvector_regions(modelvector, corpus_name);
    model.AA_mode = aa_mode;
    model.selection = selection;
    model = execute_onlinelaggedexperts(model);
    
    % normalize result by the number of predictions 
    % (in other words take the mean)
    score = mean( model.adjusted_losscs );

end



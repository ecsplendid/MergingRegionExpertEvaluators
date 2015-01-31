function [ score ] = genetic_optimizationevaluator_metamerged( ...
    modelvector, corpus_name, aa_mode, selection )
%GENETIC_OPTIMIZATIONEVALUATOR the evaluation function for the genetic
%parameter search 

    %rts1206 is the validation set
    model = model_getfromvector_metamerged(modelvector, corpus_name);
    model.AA_mode = aa_mode;
    model.selection = selection;
    load( sprintf( 'Data/PredMatrix/%s.mat', model.corpus_name ) );
    model = execute_onlinemergedrandommergedregression(model,pred_matrix);
    
    % normalize result by the number of predictions 
    % (in other words take the mean)
    score = median( model.adjusted_losscs );

end



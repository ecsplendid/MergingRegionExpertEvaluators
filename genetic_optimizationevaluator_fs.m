function [ score ] = genetic_optimizationevaluator_fs( modelvector )
%GENETIC_OPTIMIZATIONEVALUATOR the evaluation function for the genetic
%parameter search (will just take the sum of the loss, note that we intend 
%to truncate before the data goes crazy near maturity)

    model = model_getfromvector(modelvector);
    model.AA_mode = 1;
    model = execute_regionsalgorithm(model);
    score = model.adjusted_losscs(end);
end



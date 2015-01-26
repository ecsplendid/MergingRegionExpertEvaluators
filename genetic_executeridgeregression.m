function [ model ] = genetic_executeridgeregression( ...
    corpus_name, selection, genetic_model)
%GENETIC_EXECUTERIDGEREGRESSION run a genetic search for the on-line kernel
%ridge regression algorithm


nested_geneticlagged = @(modelvector)...
    genetic_optimizeridgeevaluator( ...
        modelvector,selection, corpus_name);

model = genetic_optimizeridgeregression( ...
    nested_geneticlagged, ...
    genetic_model  );

end




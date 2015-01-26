function [ model ] = genetic_executelagged( ...
    aa_mode, corpus_name, selection, description, genetic_model )
%GENETIC_EXECUTELAGGED run a genetic search for the lagged regions
%algorithm given a selection i.e. 4000:8000, aa_mode i.e. {0,1,2}
% description and a genetic model

nested_geneticlagged = @(modelvector)...
    genetic_optimizationevaluator_lagged( ...
        modelvector,corpus_name,aa_mode,selection);

model = genetic_optimizeparams( ...
    nested_geneticlagged, ...
    description, ...
    genetic_model  );

end

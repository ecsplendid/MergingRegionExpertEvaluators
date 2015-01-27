function [ best_params ] = genetic_executefixedregions( ...
    aa_mode, corpus_name, selection, description, genetic_model )
%genetic_executefixedregions run a genetic search for the lagged regions
%algorithm given a selection i.e. 4000:8000, aa_mode i.e. {0,1,2}
% description and a genetic model

nested_genetic = @(modelvector)...
    genetic_optimizationevaluator_regions( ...
        modelvector,corpus_name,aa_mode,selection);

best_params = genetic_optimizeparams_regions( ...
    nested_genetic, ...
    description, ...
    genetic_model  );

end


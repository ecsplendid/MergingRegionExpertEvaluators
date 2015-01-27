function [ model ] = genetic_executevariable( ...
    aa_mode, corpus_name, selection, ...
    description, genetic_model)
%genetic_executeridgevariable run a genetic search for the merging varible
%window sizes algorithm


nested_genetic = @(modelvector)...
    genetic_optimizationevaluator_variable( ...
        modelvector, corpus_name, aa_mode, selection);

model = genetic_optimizeparams_variable( ...
    nested_genetic, description, ...
    genetic_model  );

model.description = description;

end





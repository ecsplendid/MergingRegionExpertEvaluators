function [ model ] = genetic_executevariable( ...
    corpus_name, selection, description, genetic_model)
%genetic_executeridgevariable run a genetic search for the merging varible
%window sizes algorithm


nested_genetic = @(modelvector)...
    genetic_optimizevariableevaluator( ...
        modelvector,selection, corpus_name);

model = genetic_optimizeparams_variable( ...
    nested_genetic, description, ...
    genetic_model  );

model.description = description;

end





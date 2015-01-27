function [ options ] = genetic_getgaoptimset( genetic_model )
%GET get an options class for the GA (global optimization) routine

options = gaoptimset;
options = gaoptimset(options,'PopulationSize', genetic_model.PopulationSize );
options = gaoptimset(options,'MigrationDirection', genetic_model.MigrationDirection);
options = gaoptimset(options,'MigrationInterval', genetic_model.MigrationInterval);
options = gaoptimset(options,'MigrationFraction', genetic_model.MigrationFraction);
options = gaoptimset(options,'EliteCount', genetic_model.EliteCount);
options = gaoptimset(options,'CrossoverFraction', genetic_model.CrossoverFraction);
options = gaoptimset(options,'Generations', genetic_model.Generations);
options = gaoptimset(options,'StallGenLimit', genetic_model.StallGenLimit);
options = gaoptimset(options,'Display', 'iter');
options = gaoptimset(options,'PlotFcns', {  ...
    @gaplotbestf @gaplotbestindiv @gaplotdistance ...
    @gaplotexpectation @gaplotrange ...
    @gaplotscorediversity @gaplotscores @gaplotselection...
    @gaplotstopping });
options = gaoptimset(options,'Vectorized', 'off');
options = gaoptimset(options,'UseParallel', 1 );

end


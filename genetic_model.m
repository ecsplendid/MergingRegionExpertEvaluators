classdef genetic_model
    %GENETIC_MODEL parameters used for a genetic search
    
    properties
        PopulationSize = 80; % can be [50 50] i.e. 2 populations
        EliteCount = 5;
        CrossoverFraction = 0.5;
        
        % termination parameters (note it will also terminate if the change
        % in objective function is below a threshold)
        Generations = 30;
        StallGenLimit = 5;
        
        % relevant to multiple populations
        MigrationDirection = 'both';
        MigrationInterval = 3; % in generations
        MigrationFraction = 0.3;
    end
    
    methods
    end
    
end


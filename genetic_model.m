classdef genetic_model
    %GENETIC_MODEL parameters used for a genetic search
    
    properties
        PopulationSize = [50 50]; % can be [50 50] i.e. 2 populations
        EliteCount = 12;
        CrossoverFraction = 0.6;
        
        % termination parameters (note it will also terminate if the change
        % in objective function is below a threshold)
        Generations = 20;
        StallGenLimit = 5;
        
        % relevant to multiple populations
        MigrationDirection = 'both';
        MigrationInterval = 3; % in generations
        MigrationFraction = 0.3;
    end
    
    methods
    end
    
end


% run all the genetic searches
% (note that all the data gets saved in Models/ already automatically)

corpus_name = 'rts1206';
selection = 4000:8000;
genetic_model = genetic_model();
variable_share = 2;
fixed_share = 1;
sleeping_experts = 0;

%% LAGGED REGION MERGING ALGORITHM

% Variable Share
[ model_vslagged ] = genetic_executelagged( ...
    variable_share, corpus_name, selection, ...
    'VSLAGGED', genetic_model );

% Fixed Share
[ model_fslagged ] = genetic_executelagged( ...
    fixed_share, corpus_name, selection, ...
    'FSLAGGED', genetic_model );

% Sleeping Share
[ model_selagged ] = genetic_executelagged( ...
    sleeping_experts, corpus_name, selection, ...
    'SELAGGED', genetic_model );

%% RIDGE REGRESSION BASIC

[ model_rrbasic ] = genetic_executefixedregions( ...
    corpus_name, selection, genetic_model);

%% FIXED REGION MERGING ALGORITHM

% Variable Share
[ model_vslagged ] = genetic_executefixedregions( ...
    variable_share, corpus_name, selection, ...
    'VSLAGGED', genetic_model );


%% VARIABLE REGION MERGING ALGORITHM

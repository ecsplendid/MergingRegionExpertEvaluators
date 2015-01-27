% run all the genetic searches
% (note that all the data gets saved in Models/ already automatically)

corpus_name = 'rts1206';
selection= 1:10:10126;
genetic_model = genetic_model();
variable_share = 2;
fixed_share = 1;
sleeping_experts = 0;

%% FIXED REGION MERGING ALGORITHM

% Variable Share
[ model_vsfixed ] = genetic_executefixedregions( ...
    variable_share, corpus_name, selection, ...
    'VSFIXED', genetic_model );

% Fixed Share
[ model_fsfixed ] = genetic_executefixedregions( ...
    fixed_share, corpus_name, selection, ...
    'FSFIXED', genetic_model );

% Sleeping
[ model_sefixed ] = genetic_executefixedregions( ...
    sleeping_experts, corpus_name, selection, ...
    'SEFIXED', genetic_model );

%% VARIABLE REGION MERGING ALGORITHM

% Variable Share
[ model_vsvariable ] = genetic_executevariable( ...
    variable_share, corpus_name, selection, ...
    'VSVAR', genetic_model );

% Fixed Share
[ model_fsvariable ] = genetic_executevariable( ...
    fixed_share, corpus_name, selection, ...
    'FSVAR', genetic_model );

% SLEEPING
[ model_sevariable ] = genetic_executevariable( ...
    sleeping_experts, corpus_name, selection, ...
    'SEVAR', genetic_model );

%% RIDGE REGRESSION BASIC

[ model_rrbasic ] = genetic_executeridgeregression( ...
    corpus_name, selection, genetic_model);

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

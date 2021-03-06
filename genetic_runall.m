% run all the genetic searches
% (note that all the data gets saved in Models/ already automatically)

corpus_name = 'eeru1206';
selection= -1;
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


%% averaged random param merged regression


% Variable Share
[ model_vsrandommerged ] = genetic_executerandommerged( ...
    variable_share, corpus_name, selection, ...
    'VSRANDOMMERGED', genetic_model );

% Fixed Share
[ model_fsrandommerged ] = genetic_executerandommerged( ...
    fixed_share, corpus_name, selection, ...
    'FSRANDOMMERGED', genetic_model );

% Sleeping Share
[ model_serandommerged ] = genetic_executerandommerged( ...
    sleeping_experts, corpus_name, selection, ...
    'SERANDOMMERGED', genetic_model );

% merged random param merged regression (meta merging)

% Variable Share
[ model_vsmetamerged ] = genetic_executemetamerged( ...
    variable_share, corpus_name, selection, ...
    'VSMETAMERGED', genetic_model );

% Fixed Share
[ model_fsmetamerged ] = genetic_executemetamerged( ...
    fixed_share, corpus_name, selection, ...
    'FSMETAMERGED', genetic_model );

% Sleeping Share
[ model_semetamerged ] = genetic_executemetamerged( ...
    sleeping_experts, corpus_name, selection, ...
    'SEMETAMERGED', genetic_model );



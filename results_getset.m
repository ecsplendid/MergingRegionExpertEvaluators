function [ results ] = results_getset( ...
    setname, set_corpus, selection, scale_up )
%RESULTS_GETSET Summary of this function goes here
%from which results set i.e. Models/<setname>/*.*
%collates all results model files into a results_set and executes them in
%the corpus requested
%if the record skip was 10 i.e. selection of 1:10:4000, set scale_up to 10
%as a multiplier for numexperts and windowsize

results = results_set();

fpath = 'Models/%s/best_model_%s.mat';

% fixed algorithm
results.Fixed_FS = load( sprintf( fpath, setname, 'FSFIXED' ) );
results.Fixed_FS.model.corpus_name = set_corpus;
results.Fixed_FS.model.selection = selection;
results.Fixed_FS.model.maxlag_timehorizon=results.Fixed_FS.model.maxlag_timehorizon*scale_up;
results.Fixed_FS.model.num_expertevaluators=results.Fixed_FS.model.num_expertevaluators*scale_up;
results.Fixed_FS.model.window_size=results.Fixed_FS.model.window_size*scale_up;
results.Fixed_FS.model = execute_onlinefixedregions(results.Fixed_FS.model);

% results.Fixed_VS = load( sprintf( fpath, setname, 'VSFIXED' ) );
% results.Fixed_VS.model.corpus_name = set_corpus;
% results.Fixed_VS.model.selection = selection;
% results.Fixed_VS.model = execute_onlinefixedregions(results.Fixed_VS.model);
% 
% results.Fixed_Sleeping = load( sprintf( fpath, setname, 'SEFIXED' ) );
% results.Fixed_Sleeping.model.corpus_name = set_corpus;
% results.Fixed_Sleeping.model.selection = selection;
% results.Fixed_Sleeping.model = execute_onlinefixedregions(results.Fixed_Sleeping.model);
% 
% %variable algorithm
% results.Variable_FS = load( sprintf( fpath, setname, 'FSVAR' ) );
% results.Variable_FS.model.corpus_name = set_corpus;
% results.Variable_FS.model.selection = selection;
% results.Variable_FS.model = execute_onlinevariablemergedregression(results.Variable_FS.model);
% 
% results.Variable_VS = load( sprintf( fpath, setname, 'VSVAR' ) );
% results.Variable_VS.model.corpus_name = set_corpus;
% results.Variable_VS.model.selection = selection;
% results.Variable_VS.model = execute_onlinevariablemergedregression(results.Variable_VS.model);
% 
% results.Variable_Sleeping = load( sprintf( fpath, setname, 'SEVAR' ) );
% results.Variable_Sleeping.model.corpus_name = set_corpus;
% results.Variable_Sleeping.model.selection = selection;
% results.Variable_Sleeping.model = execute_onlinevariablemergedregression(results.Variable_Sleeping.model);
% 
% %lagged algorithm
% results.Lagged_FS = load( sprintf( fpath, setname, 'FSLAGGED' ) );
% results.Lagged_FS.model.corpus_name = set_corpus;
% results.Lagged_FS.model.selection = selection;
% results.Lagged_FS.model = execute_onlinelaggedexperts(results.Lagged_FS.model);
% 
% results.Lagged_VS = load( sprintf( fpath, setname, 'VSLAGGED' ) );
% results.Lagged_VS.model.corpus_name = set_corpus;
% results.Lagged_VS.model.selection = selection;
% results.Lagged_VS.model = execute_onlinelaggedexperts(results.Lagged_VS.model);
% 
% results.Lagged_Sleeping = load( sprintf( fpath, setname, 'SELAGGED' ) );
% results.Lagged_Sleeping.model.corpus_name = set_corpus;
% results.Lagged_Sleeping.model.selection = selection;
% results.Lagged_Sleeping.model = execute_onlinelaggedexperts(results.Lagged_Sleeping.model);
% 
% %simple ridge
% results.Ridge = load( sprintf( fpath, setname, 'ridgesimple' ) );
% results.Ridge.model.corpus_name = set_corpus;
% results.Ridge.model.selection = selection;
% results.Ridge.model = execute_onlinebasicregression(results.Ridge.model);

end


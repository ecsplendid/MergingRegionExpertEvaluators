function [ output_args ] = batch_generaterandompreds( input_args )
%BATCH_GENERATERANDOMPREDS generate a pred matrix for all the 3 main
%corpuses and save it to a file

model = region_model;
model.corpus_name = 'eeru1206';
model.degrees = 1:7;
model.window_sizes = 50:10:350;
model.ridges = 0.1:0.1:5;
model.selection = -1;
model.num_expertevaluators = 500;
model.AA_mode = 2;
model.alpha = 0.7; 
randmodel = execute_onlinerandommergedregression( model  );


randmodel.pred_matrix

end


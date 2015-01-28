function pred_matrix = batch_generaterandompreds( ...
    corpus_name, number_experts )
%BATCH_GENERATERANDOMPREDS generate a pred matrix for all the 3 main
%corpuses and save it to a file with random degrees, window sizes and
%ridges

model = region_model;
model.corpus_name = corpus_name;
model.degrees = 1:7;
model.window_sizes = 50:10:350;
model.ridges = 0.1:0.1:5;
model.selection = -1;
model.num_expertevaluators = number_experts;
model.AA_mode = 2;
model.alpha = 0.7; 
randmodel = execute_onlinerandommergedregression( model  );

pred_matrix = randmodel.pred_matrix;

save( ...
    sprintf( './Data/PredMatrix/%s.mat', model.corpus_name ), ...
    'pred_matrix' );

end


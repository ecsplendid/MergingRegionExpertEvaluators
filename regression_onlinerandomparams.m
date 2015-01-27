function [ preds, losses ] = regression_onlinerandomparams( ...
    corpus, labels, ...
    window_sizes, ridges, degrees, ...
    num_expertevaluators )
%regression_onlinerandomparams will produce a matrix of num_expertevaluator
%sliding window ridge regression predictors of random parameters

pred_cells = cell( 1, num_expertevaluators );
loss_cells = cell( 1, num_expertevaluators );

parfor e=1:num_expertevaluators
    
    ridge_coeff = ridges(floor(rand*length(ridges))+1);
    window_size = window_sizes(floor(rand*length(window_sizes))+1);
    degree = degrees(floor(rand*length(degrees))+1);
    
    kernel = @(X,y) kernel_polynomial(X,y, degree);
    
    [P, L] = regression_basic...
        ( corpus, labels, kernel, window_size, ridge_coeff );
    
    pred_cells{e} = [nan(window_size,1); P];
    loss_cells{e} = [nan(window_size,1); L];
end

preds = cell2mat(pred_cells);
losses = cell2mat(loss_cells);



end


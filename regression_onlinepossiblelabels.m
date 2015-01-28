function [pred_matrix] = regression_onlinepossiblelabels...
    ( corpus, num_expertevaluators, label_min, label_max )
%regression_onlinepossiblelabels
%experts are num_expertevaluators possible labels from label_min to label_max

labels=  ...
        linspace( ...
            label_min, label_max, num_expertevaluators ...
             );

pred_matrix = nan( size(corpus,2), num_expertevaluators );

for l=1:length(labels)
    
    pred_matrix(:, l ) = ones( size(corpus,2), 1 ).*labels(l);
  
end

end
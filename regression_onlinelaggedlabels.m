function [pred_matrix] = regression_onlinelaggedlabels...
    ( corpus, labels, num_expertevaluators, maxlag_timehorizon )
%regression_onlinelaggedlabels
%experts are labels in the lagged past
%window_size: the size of the window used to train the kernel ridge
%regression
%num_expertevaluators: how many expert evaulators to create
%maxlag_timehorizon: up to this maximum lag horizon (on a linear mapping from
%no lag at all)


lags = floor( ...
        linspace( ...
            2, maxlag_timehorizon, num_expertevaluators ...
            ) );

pred_matrix = nan( size(corpus,2), num_expertevaluators );

for l=1:length(lags)
    
    lag = lags(l);

    pred_matrix(lag:end, l ) = labels(1:end-lag+1)';
    
end

end
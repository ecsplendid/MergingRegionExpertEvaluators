function [preds losses] = get_regressionregionevaluators...
    ( data, labels, kernel, window_size, ridge_coeff, ...
    num_expertevaulators, maxlag_timehorizon )
%get_regressionregionevaluators 
%return a matrix of expert evaulators issuing predictions after their
%underlying region has been fully revealed. 
%window_size: the size of the window used to train the kernel ridge
%regression
%num_expertevaulators: how many expert evaulators to create
%maxlag_timehorizon: up to this maximum lag horizon (on a linear mapping from
%no lag at all)

K = zeros(window_size,window_size);
for i=1:window_size
      K(i,i:window_size) = kernel(data(:,i:window_size),data(:,i));
end

try
    U = chol(ridge_coeff * eye(window_size, window_size) + K);
catch ex
    % this should not happen. Debug your kernel. Here is some info
    M = ridge_coeff * eye(window_size, window_size) + K;
    eig(M)
    rethrow(ex);
end

lags = floor(linspace( maxlag_timehorizon, 0, num_expertevaulators ));

preds = nan( size(data,2), num_expertevaulators );
losses = nan( size(data,2), num_expertevaulators );

for t = window_size+1:size(data,2)
    
    % here U is the chol factor of aI + K, where
    % K is the kernelmatrix of the window_size many samples just before t.
    
    train_window = data(:, t-window_size:t-1);
    train_labels = labels(t-window_size:t-1)';
    
    index = 1;
    
    % now for this model, make predictions at points in the future
    % depending on the lags variable
    % lags is going from HIGH to 0, so that k remains as it was for chol
    % update
    for l=1:length(lags)

        lag = lags(l);
        
        % need a break condition, if t+lag>N
        if (lag + t) > size(data,2), continue, end;
        
        k = kernel(train_window,data(:,t+lag))';

        % matlab knows how to do substitutions on triangular matrices.
        inv_part = (U \ (U' \ train_labels))';

        y = inv_part * k;
        
        preds(t+lag, num_expertevaulators-l+1 ) = y;
        losses(t+lag, num_expertevaulators-l+1 ) = (y-labels(t+lag))^2;
    
        index = index + 1;
        
    end
    
    % Cholesky factor update
    % grow REMEMBER THAT k needs to end up effective for t
    y = U' \ k;
    z = sqrt(ridge_coeff + kernel(data(:,t), data(:,t)) - y'*y);
    Wm = [ U y ; zeros(1,window_size) z];
    % shrink
    
    y = Wm(1,2:end);
    U = cholupdate(Wm(2:end,2:end), y');
end
end
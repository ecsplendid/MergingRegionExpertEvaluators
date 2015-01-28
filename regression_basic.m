function [preds, losses] = regression_basic(...
    data, labels, kernel, window_size, a)
%regression_basic perform sliding window kernel ridge regression,
%using the Cholesky factor update so it runs in linear time (FAST), returns
%predictions and square losses

K = zeros(window_size,window_size);
for i=1:window_size
      K(i,i:window_size) = kernel(data(:,i:window_size),data(:,i));
end

try
    U = chol(a * eye(window_size, window_size) + K);
catch ex
    % this should not happen. Debug your kernel. Here is some info
    M = a * eye(window_size, window_size) + K;
    eig(M)
    rethrow(ex);
end

preds = nan( size(data,2)-window_size, 1 );
losses = nan( size(data,2)-window_size, 1 );

Wm = nan( window_size+1, window_size+1 );

for t = window_size+1 : size(data,2)
    % here U is the chol factor of aI + K, where
    % K is the kernelmatrix of the window_size many samples just before t.
    
    k = kernel(data(:, t-window_size:t-1),data(:,t))';
    
    % matlab knows how to do substitutions on triangular matrices.
    inv_part = (U \ (U' \ labels(t-window_size:t-1)'))';
    
    index = t-window_size;
    y = inv_part * k;
    preds(index)= y;
    losses(index) = (y-labels(t))^2;
    
    % Cholesky factor update
    
    % grow
    y = U' \ k;
    z = sqrt(a + kernel(data(:,t), data(:,t)) - y'*y);
   % Wm = [ U y ; zeros(1,window_size) z];
    
    % faster version -- preallocated
    Wm( 1:end-1, 1:end-1 ) = U;
    Wm( 1:end-1, end ) = y;
    Wm( end, 1:end-1 ) = zeros(1,window_size);
    Wm( end, end ) = z;
    
    % shrink
    
    y = Wm(1,2:end);
    U = cholupdate(Wm(2:end,2:end), y');
end
end
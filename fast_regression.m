function losses = regression( ...
    data, labels, kernel, kernelParameters, window_size, a)

K = zeros(window_size,window_size);
for i=1:window_size
      K(i,i:end) = kernel(data(:,i:100),data(:,i),kernelParameters);
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

for t = window_size+1 : size(data,2)
    % here U is the chol factor of aI + K, where
    % K is the kernelmatrix of the window_size many samples just before t.
    
    k = kernel(data(:, t-window_size:t-1),data(:,t),kernelParameters)';
    
    % matlab knows how to do substitutions on triangular matrices.
    inv_part = (U \ (U' \ labels(t-window_size:t-1)'))';
    
    index = t-window_size;
    y = inv_part * k;
    preds(index)= y;
    losses(index) = (y-labels(t))^2;
    
    % Cholesky factor update
    
    % grow
    y = U' \ k;
    z = sqrt(a + kernel(data(:,t), data(:,t),kernelParameters) - y'*y);
    Wm = [ U y ; zeros(1,window_size) z];
    % shrink
    y = Wm(1,2:end);
    U = cholupdate(Wm(2:end,2:end), y');
end
end
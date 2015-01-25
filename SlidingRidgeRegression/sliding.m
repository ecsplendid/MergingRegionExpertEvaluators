function losses = sliding(attributes, outcomes, windowSize, a, ...
    KVectFunction, kernelParameters)

% sliding(attributes,outcomes,windowSize,a,KVectFunction,kernel_parameters) 
% applies sliding window ridge regression with the window size windowSize, 
% ridge of a
% (to work with a*trace(K)/n, change regressor.m)
% KVectFunction is a pointer to a function evaluating a kernel on columns
% of X1 and vector x2
% kernel_parameters are passed to the kernel function as they are
% 
% attributes contains vectors as columns
% for historical reasons...

[numAttributes, numVects] = size(attributes);

gamma=outcomes; % we fill predictions with outcomes; then we overwrite them

for t = windowSize+1:numVects % master loop
    
    % getting last windowSize examples
    X = attributes(:,(t-windowSize):(t-1));
    Y = outcomes(:,(t-windowSize):(t-1))';
    
    % the current example
    xCurrent = attributes(:,t);
    
    % the necessary vectors
    k = feval(KVectFunction,X,xCurrent,kernelParameters);
    YinvKaI = regressor(X,Y,a,KVectFunction,kernelParameters);

    % predictions
    gamma(t) = YinvKaI*k';
end

losses = (gamma-outcomes).^2;
losses = losses(windowSize+1:end)';
function reg = regressor(X,Y,a,KVectFunction,kernelParameters)

% REGRESSOR(X,Y,a,KVectFunction,kernelParameters) calculates the vector Y'(K+a0*I)^(-1) for the design matrix X 
% COLUMNS of X are datapoints
% KVectFunction is a pointer to a function evaluating a kernel on columns
% of X1 and vector x2
% a0 = a*trace(K)/n
% kernelParameters are passed to the kernel function as they are

[numArgs,numVects] = size(X);

% sanity check; comment this out to save space if you are sure everything works fine
[n m] = size(Y);

if m ~= 1
    Y = Y';
    disp('YK regressor warning: Y transposed');
end

[n m] = size(Y);

if m ~= 1
    error('YK regressor: Y should be a vector');
end

if n ~= numVects
    error('YK regressor: the size of Y should match the number of columns in X');
end
% end of sanity check

% creating the kernel matrix
K = [];
diagonal = [];

for i = 1:numVects
    u = KVectFunction( X(:,i:end),X(:,i),kernelParameters);
    K  = [K; zeros(1,i-1) u];
end

diagonal = diag(K);
K = K+K'-diag(diagonal);

% calculating Y'(K+aI)^(-1)
% I hope Matlab will find the right method to solve the system

% a simple version with a used as it is:
reg = ((K+a*eye(numVects))\Y)';

% a version with a*trace(K)/n 
% reg = ((K+a*mean(diagonal)*eye(numVects))\Y)';

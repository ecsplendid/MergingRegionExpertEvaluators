function K = kernel_polynomial(X1,x2,d)

% kernel_polynomial(X1,x2,d) evaluates Vapnik's polynomial kernel 
% on COLUMNS of X1 and vector x2; K(x1,x2) = (1+x1'x2)^d

[numArgs,numVects] = size(X1);

% sanity check; comment this out to save space 
% if you are sure everything works fine
[n m] = size(x2);

if m~= 1
    x2 = x2';
    disp('YK kernel_polynomial warning: x2 transposed');
end

[n m] = size(x2);

if m ~= 1
    error('YK kernel_polynomial usage: x2 should be a vector');
end

if numArgs ~= n
    error('YK kernel_polynomial usage: the column length of X1 should match the length of x2')
end
% end of sanity check

K = (sum(X1.*repmat(x2,1,numVects),1)+1).^d;
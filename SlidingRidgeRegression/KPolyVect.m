function K = KPolyVect(X1,x2,d)

% KPolyVect(X1,x2,d) evaluates Vapnik's polynomial kernel 
% on COLUMNS of X1 and vector x2; K(x1,x2) = (1+x1'x2)^d

[numArgs,numVects] = size(X1);

% sanity check; comment this out to save space if you are sure everything works fine
[n m] = size(x2);

if m~= 1
    x2 = x2';
    disp('YK KPolyVect warning: x2 transposed');
end

[n m] = size(x2);

if m ~= 1
    error('YK KPolyVect usage: x2 should be a vector');
end

if numArgs ~= n
    error('YK KPolyVect usage: the column length of X1 should match the length of x2')
end
% end of sanity check

K = (sum(X1.*repmat(x2,1,numVects),1)+1).^d;
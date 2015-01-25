raw  = dlmread('gaz307.csv',',',1,1 );

% trs @ 2208 new signals
data = raw(:,[7,8,9,19])';

for r = 1 : size(data, 1)
    data(r,:) = (data(r,:) - min(data(r,:)))/(max(data(r,:))-min(data(r,:)));
end

labels = raw(:,10)';
labels(labels>1) = 1;

sigma = 0.25;

kernel = @(X,y,sigma) KRBFVect(X,y,sigma);
window_size = 100;
a = 0.016;

tic
% upper triangle of kernel matrix
K = nan(size(data,2),size(data,2));
for i=1:size(data,2)
    if mod(i,100) == 0 ; disp(i); end
    K(i,i:size(data,2)) = kernel(data(:,i:size(data,2)), data(:,i),sigma);
end
toc

nregions = floor(size(data,2) / window_size);
L = nan(nregions,nregions);

for e = 1:nregions
    train_region = (e-1)*window_size + (1:window_size);
    % train expert on region e
    U = chol(a * eye(window_size, window_size) + K(train_region, train_region));
    inv = (U \ (U' \ labels(train_region)'))';
    
    % predict all future regions
    for j = e+1 : nregions
        test_region = (j-1)*window_size + (1:window_size);
        pred = inv * K(train_region, test_region);
        L(e,j) = sum((pred - labels(test_region)).^2);
    end
end

colormap(hot);
image(64-L/44*500); 
axis xy;

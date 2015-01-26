
corpus_name = 'eeru1206';

[ data, labels, competitor ] = get_corpus( corpus_name );

window_size = 200;
a = 1.24;
degree = 4;

kernel = @(X,y) kernel_polynomial(X,y,degree);

tic
% upper triangle of kernel matrix
K = nan(size(data,2),size(data,2));
for i=1:size(data,2)
    if mod(i,100) == 0 ; disp(i); end
    K(i,i:size(data,2)) = kernel(data(:,i:size(data,2)), data(:,i));
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

%%
colormap(hot);
imagesc(log(L));
colorbar;
axis xy;

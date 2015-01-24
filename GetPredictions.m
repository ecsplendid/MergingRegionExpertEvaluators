%function [ P ] = GetPredictionMatrix( )
%GETPREDICTIONMATRIX Summary of this function goes here
%   Detailed explanation goes here

clear all;

alpha = 0.8;
degree = 4;
window_size = 700;
a = 1;
region_count = 50;

name = 'rts307';

raw = load([name '.csv']);
% the first line should be removed in advance
% cannot specify comma-separated format in this version of MATLAB
% therefore column 7

% trs @ 2208 new signals
data = raw(:,[7,8,9,19])';

% scale
for r = 1 : size(data, 1)
    data(r,:) = (data(r,:) - min(data(r,:)))/(max(data(r,:))-min(data(r,:)));
    data(r,:) = (data(r,:).*2)-1;
end

labels = raw(:,10)';
%labels(labels>1) = 1;

% todo: find best sigma
kernel = @(X,y,sigma) KPolyVect(X,y,degree);

truncate_limit = size( data, 2 );
%truncate_limit = 6000;

data = data(:,1:truncate_limit);
labels = labels(1:truncate_limit)

% could do this inline to save memory
tic
% upper triangle of kernel matrix
K = nan(truncate_limit,truncate_limit);
for i=1:truncate_limit
    if mod(i,100) == 0 ; disp(i); end
    K(i,i:truncate_limit) = kernel(data(:,i:truncate_limit), data(:,i),degree);
end
toc

% make a prediction matrix, we want to have sliding window
% to save hassel of growing a window at start, we go from window_size+1

region_map = GenerateRegionMap( region_count, window_size, truncate_limit );

pmatrix_size = truncate_limit - window_size;

L = nan(truncate_limit,region_count);
P = nan(truncate_limit, region_count);

for r=1:size(region_map,1)
    
    train_region = region_map(r,1) : region_map(r,2);
    % train expert on region e
    U = chol(a * eye(window_size, window_size) + K(train_region, train_region));
    inv = (U \ (U' \ labels(train_region)'))';
    
    % predict all data in the future of this region (1 record past end)
    for rc = (region_map(r,2)+1):truncate_limit
        
        pred = inv * K(train_region, rc);
       
        P(rc,r) = pred;
        L(rc,r) = (pred-labels(rc)).^2;
        
    end
end

% vis loss matrix

LS = nan(region_count,region_count);

rs = floor( linspace( 1, pmatrix_size, region_count+1 ) );

for i=1:region_count
   
    for y = 1:region_count
       
        ran = rs(y):rs(y+1)-1;
        
        LS(y,i) = mean( L(ran, i ) );
        
    end
    
end

imagesc(log(LS));
colorbar;
axis square;


ylabel( 'Record Number' );
xlabel( 'Region Number' );
set(gca,'YTickLabel', round(linspace(1,truncate_limit,8)) )



%%
alpha = 0.999;
[losses preds weights_saved] = AA( P((region_map(1,2)+1):end,:), ...
        labels((region_map(1,2)+1):end), alpha, 2);


imagesc(weights_saved)
sum(losses)

%%

imagesc(log(weights_saved))

% bench mark score for this dataset

competitor = raw(1:truncate_limit,11)./100;
volatility = raw(1:truncate_limit,10);

volatility= labels';

complosses = (competitor - volatility).^2;

difference = (losses - complosses((region_map(1,2)+1):end)');
%plot(cumsum(difference(window_size+1:end)),'b:');
%grid on;
legend(sprintf('Regions compared to competitor (%s)',name));
colorbar;


%% basic comparison

%plot( cumsum( complosses((region_map(1,2)+1):end)) );
%hold on
%plot( cumsum( losses ),'r:');
%hold off;

%legend( 'competitor','our regions algoriothm' )

%%
%plot(cumsum(complosses))
% experiment using just last element lagged, not any mention in thesis..

clear all;
alpha = 1;
number_lags = 10;
skip_interval = 3;
aa_alg = 2;

name = 'eeru1206';

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

truncate_limit = size(data, 2);
truncate_limit = size(data,2);

data = data(:,1:truncate_limit);
labels = labels(1:truncate_limit)

P = nan( truncate_limit, number_lags );

for i=1:skip_interval:(number_lags*skip_interval)
    selection = 1:truncate_limit-i;
    placement = i+1:i+length(selection);
    
    P( placement, ((i-1)/skip_interval)+1) = labels( selection );
end

[losses preds weights_saved] = AA( P(2:end,:), ...
        labels(2:end), alpha, aa_alg);

%imagesc(log(weights_saved(100:end-1000,:))')
%axis xy
   
%sum(losses)
%imagesc(log(weights_saved))
%colorbar;
% bench mark score for this dataset

competitor = raw(1:truncate_limit,11)./100;
volatility = raw(1:truncate_limit,10);

volatility= labels';

complosses = (competitor - volatility).^2;

difference = (losses(1:end) - complosses(2:end)');
plot(cumsum(difference),'k');
%hold on

%sliding_difference = (L((window_size+1):end,1) - complosses((window_size+1):end));
%plot(cumsum(sliding_difference),'r:');

grid on;
legend('Lags Algorithm');

%% basic comparison

plot( cumsum( complosses((region_map(1,2)+1):end)) );
hold on
plot( cumsum( losses ),'r:');
hold off;

legend( 'competitor','our regions algoriothm' )

%%
plot(cumsum(complosses))
%function [ P ] = GetPredictionMatrix( )
%GETPREDICTIONMATRIX Summary of this function goes here
%   Detailed explanation goes here



%% s

name = 'rts307';
max_lags = 400;
degree = 4;
window_size = 100;
a = 0.5;
num_lags = 20;

raw = load([name '.csv']);
% the first line should be removed in advance
% cannot specify comma-separated format in this version of MATLAB
% therefore column 7

% trs @ 2208 new signals
data = raw(:,[7,8,9,19])';


all_losses = nan( size( data, 2 ), 3 );
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
%truncate_limit = 4000;

data = data(:,1:truncate_limit);
labels = labels(1:truncate_limit);

[P L] = regression_lagged ...
    (data, labels, kernel, window_size, a, num_lags, max_lags);


%imagesc(log(L));

[ diffsvs cums losses preds weights_saved_vs ] = run_pwea( P, 0.99999, 2, raw, labels, truncate_limit, window_size  );

all_losses( window_size+1:end, 1 ) = cums;

[ diffsfs cums losses preds weights_saved_fs ] = run_pwea( P, 0.00001, 1, raw, labels, truncate_limit, window_size  );

all_losses( window_size+1:end, 2 ) = cums;

[ diffsaa cums losses preds weights_saved_aa ] = run_pwea( P, 0.00001, 0, raw, labels, truncate_limit, window_size  );

all_losses( window_size+1:end, 3 ) = cums;

res = [diffsvs;diffsfs;diffsaa ]

min(res)

plot( (all_losses( window_size+1:end,1 ) ), 'g');
hold on;
plot( (all_losses( window_size+1:end,2 ) ), 'r');

plot( (all_losses( window_size+1:end,3 ) ), 'b');

%set(gca,'xcolor',[.8 .8 .8],'ycolor',[.8 .8 .8]);
hold off;
grid on;
axis tight;
axis square;
legend('Variable Share \alpha=0.999','Fixed Share \alpha=0.00001','AAS','Location','SouthWest' )
xlabel('Record Number')
ylabel('Cumulative Square Loss')
title( ['Lagged Region Experts ' name ' (30 Experts)' ] );

%clear all;


figure(gcf)
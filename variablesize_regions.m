%function [ P ] = GetPredictionMatrix( )
%GETPREDICTIONMATRIX Summary of this function goes here
%   Detailed explanation goes here

%clear all;

window_size = 20; 
a = 5;
degree = 4;

filename = 'eeru1206';

rawdata = load( [ 'Data/' filename '.csv' ],','  );

strikes = rawdata(:,7);
puts = rawdata(:,8);
volatility = rawdata(:,10);
assetprice = rawdata(:,9);

[R C] = size(rawdata);

volatility_adjusted = volatility;
volatility_adjusted(volatility_adjusted>1) = 1;

competitor = rawdata(:,11)./100;
time = rawdata(:,19);

%[ 0.5; volatility_adjusted(1:end-1) ]
data = [  strikes puts assetprice time ]; 

% normalize
for i=1:size(data,2)   
    data(:,i) =  (data(:,i) - min(data(:,i))) ./ (max(data(:,i)) - min(data(:,i)));
    % -1,1 interval is good for the polynomial kernel
    data(:,i) = (data(:,i).*2)-1;
end

kernel = @(x,y) (1 + x'*y).^degree;

window_sizes = [ 200 100 50 ];
lags = [10:60:300];


L = nan(R, length(lags) );
P = nan(R, length(lags) );

%%

kernel = @(x,y) (1 + x'*y).^degree;

for i=1:length(window_sizes)
   
     window_size = window_sizes(i)
   
     for l=1:length(lags)
     
         lag = lags(l);
         
         [preds losses] = regression_lagged( data', volatility_adjusted, ...
             kernel, window_size, a, lag );

         P( window_size+1:end, L ) = preds;
     
     end
end

[preds losses] = regression( data', volatility_adjusted, ...
         kernel, 200, a );

losses_200ref = losses;

%%

start_from = (window_sizes(end)+1);

alpha = 0.0001;

[losses preds weights_saved] = AA( P(start_from:end,1:end), ...
        volatility_adjusted(start_from:end), alpha, 1);

  %  imagesc(log(weights_saved'))
  %  axis xy
  
%sum(losses)
%imagesc(weights_saved)

% bench mark score for this dataset

competitor = rawdata(:,11)./100;
volatility = rawdata(:,10);


complosses = (competitor - volatility_adjusted).^2;

difference = (losses - complosses(start_from:end));
difference_standard200 = (losses_200ref((start_from-200):end) ...
    - complosses(start_from:end));

plot(cumsum(difference(window_size+1:end)),'b');
hold on;
plot(cumsum(difference_standard200(window_size+1:end)),'r:');
hold off;
grid on;
legend('Mixed window sizes','Reference 200 window size');
title(filename)
%% basic comparison

%plot( cumsum( complosses((region_map(1,2)+1):end)) );
%hold on
%plot( cumsum( losses ),'r:');
%hold off;

%legend( 'competitor','our regions algoriothm' )

%% lag test


[preds losses] = regression_lagged( data', volatility_adjusted, ...
    @(x,y) (1 + x'*y).^2, 200, 1, 100 );



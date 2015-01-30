function [ corpus, labels, competitor, rawstrikes, timematurity ] ...
    = get_corpus( ...
    corpus_name, selection, signal_type )
%get_corpus Load the data from the corpus requested
% and normalize it
% (signal_type==1) 

if nargin < 3
   signal_type = 1;
end

strike_price = 7;
putcall = 8;
underlier_price = 9;
timematurity = 19;

if signal_type == 1
   signal = [ strike_price, putcall, timematurity ];
else
   signal = [ strike_price, putcall, timematurity, underlier_price ];
end

raw = load(['Data/' corpus_name '.csv']);
% the first line should be removed in advance
% cannot specify comma-separated format in this version of MATLAB
% therefore column 7


rawstrikes = raw(:,strike_price)';
timematurity = raw(:,timematurity)';

corpus = raw(:,signal)';

% scale it to [-1,1] because polynomial kernel is used (use [0,1] for rbf)
for r = 1 : size(corpus, 1)
    corpus(r,:) = (corpus(r,:) - ...
        min(corpus(r,:)))/(max(corpus(r,:))-min(corpus(r,:)));
    corpus(r,:) = (corpus(r,:)*2)-1;
end

labels = raw(:,10)';

% the RTSSE competitor predictions
competitor = raw(:,11)./100;

if nargin > 1 && length(selection) > 1

    labels = labels(selection);
    corpus = corpus(:,selection);
    competitor = competitor(selection);
end

end


function [ corpus, labels, competitor ] = get_corpus( ...
    corpus_name, truncate )
%get_corpus Load the data from the corpus requestes
% and normalize it

raw = load(['Data/' corpus_name '.csv']);
% the first line should be removed in advance
% cannot specify comma-separated format in this version of MATLAB
% therefore column 7

corpus = raw(:,[7,8,9,19])';

% scale it to [-1,1] because polynomial kernel is used (use [0,1] for rbf)
for r = 1 : size(corpus, 1)
    corpus(r,:) = (corpus(r,:) - ...
        min(corpus(r,:)))/(max(corpus(r,:))-min(corpus(r,:)));
    corpus(r,:) = (corpus(r,:).*2)-1;
end

labels = raw(:,10)';

% cap the signals at 1 to remove outliers
% could later just remove them entirely?
labels(labels>1) = 1;

% the RTSSE competitor predictions
competitor = raw(:,11)./100;

    if nargin > 1 && truncate ~= -1
        competitor = competitor(1:truncate);
        labels = labels(1:truncate);
        corpus = corpus(:,1:truncate);
    end

end


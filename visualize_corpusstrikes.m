function [  ] = visualize_corpusstrikes( corpus_name )
%VISUALIZE_CORPUS Do some plots of the labels in a corpus - will also save them to 
% /Models/
%%

if nargin == 0
   corpus_name = 'gaz307'; 
end

[ corpus, labels, ~, rawstrikes, timematurity ] = ...
    get_corpus( corpus_name, -1 );

wins = 100;
window_size = 300;

region_indices = floor( ...
    linspace(wins+1, length(rawstrikes), wins ) ...
    );

hFig = figure(1);
set(hFig, 'Position', [100 100 500 500])

xvals = unique(rawstrikes);
    
imap = nan( wins, length(xvals) );

for r=1:wins-1

    region = max(1,... 
            (region_indices(r+1)-window_size)...
            ):region_indices(r+1)-1;
    
        
    [x, ~] = hist(rawstrikes(region), xvals );
    
    imap(r,:) = fliplr(x);
        
end

imagesc((imap)');
title(sprintf('Strike Distribution Spectrogram (%s)', corpus_name));
xlabel('Record Number');
ylabel('Strike Value');
set(gca,'YTickLabel', fliplr(xvals) );
set(gca,'YTick', 1:length(rawstrikes) );

num_labels = 10;
set(gca,'XTickLabel', floor(linspace(1,length(labels),num_labels) ) );
set(gca,'XTick', floor(linspace(1,wins,num_labels) ) );
axis square;

print(gcf, '-depsc2', sprintf('Figures/strike_spectrogram_%s.eps', corpus_name));

end


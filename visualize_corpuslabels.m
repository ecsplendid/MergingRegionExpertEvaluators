function [  ] = visualize_corpuslabels( corpus_name )
%VISUALIZE_CORPUS Do some plots of the labels in a corpus - will also save them to 
% /Models/
%%

if nargin == 0
   corpus_name = 'gaz307'; 
end

hFig = figure(1);
set(hFig, 'Position', [100 100 400 400])

[ ~, labels, ~ ] = get_corpus( corpus_name, -1 );

labels(labels>1)=1;

plot(labels,'k')
axis tight
xlabel('Record')
ylabel('Label')
axis square;

print(gcf, '-depsc2', sprintf('Figures/label_plot_%s.eps', corpus_name));

title(sprintf('Label Distribution Plot (%s)', corpus_name));

wins = 1000;
window_size = 100;

region_indices = floor( ...
    linspace(wins+1, length(labels), wins ) ...
    );


hFig = figure(2);
set(hFig, 'Position', [100 100 400 400])

xvals = 0:0.009:1;
    
imap = nan( wins, length(xvals) );

for r=1:wins-1

    region = max(1,... 
            (region_indices(r+1)-window_size)...
            ):region_indices(r+1)-1;
    
        
    [x, ~] = hist(labels(region), xvals );
    
    imap(r,:) = x;
        
end

imagesc(log(imap)');
title(sprintf('Label Distribution Spectrogram (%s)', corpus_name));
xlabel('Record Number');
ylabel('Label Value Distribution');
set(gca,'YTickLabel', [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1] );
set(gca,'YTick', 1:10:length(xvals) );

num_labels = 10;
set(gca,'XTickLabel', floor(linspace(1,length(labels),num_labels) ) );
set(gca,'XTick', floor(linspace(1,1000,num_labels) ) );
axis square;

print(gcf, '-depsc2', sprintf('Figures/label_spectrogram_%s.eps', corpus_name));

end


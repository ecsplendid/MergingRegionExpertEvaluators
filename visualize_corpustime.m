function [  ] = visualize_corpustime(  )
%visualize_corpustime visualize time progression in the corpora
%%
[ corpus, labels, ~, rawstrikes, timematurity ] = ...
    get_corpus( 'eeru1206', -1 );

plot(1-timematurity, 'k:', 'LineWidth',2);
hold on;

[ corpus, labels, ~, rawstrikes, timematurity ] = ...
    get_corpus( 'gaz307', -1 );

plot(1-timematurity, 'k', 'LineWidth',2);

[ corpus, labels, ~, rawstrikes, timematurity ] = ...
    get_corpus( 'rts307', -1 );

plot(1-timematurity, 'k--', 'LineWidth',3);

hold off;
axis tight
set(gca,'ylim',[0.7 1]);
title('1-time to maturity for corpora');
xlabel('Record')
ylabel('1-Time To Maturity')
legend('eeru1206','gaz307','rts307','Location','NorthWest');
axis square;
print(gcf, '-depsc2', sprintf('Figures/time_progression.eps', corpus_name));


end


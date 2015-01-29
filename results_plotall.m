function [  ] = results_plotall( set_corpus, description )
%RESULTS_PLOTALL Plot results
%%

    hFig = figure(1);
    % ensure all figures are the same size
    % I've finally learned my less on this after about a million years!
    set(hFig, 'Position', [600 1 400 400])
    
    plot(set_corpus.Fixed_FS.model.adjusted_losscs,'k','LineWidth',2)
    hold on;
    plot(set_corpus.Fixed_VS.model.adjusted_losscs,'r','LineWidth',2)
    plot(set_corpus.Fixed_Sleeping.model.adjusted_losscs,'b','LineWidth',2)
    title('Merging Fixed Regions eeru1206');
    ylabel('Cumulative Squared Loss');
    xlabel('Record Number');
    legend('Fixed Share', 'Variable Share', 'AA+Sleeping Experts', ...
        'Location','NorthWest')
    
    hold off;
    grid on;
    
    print(gcf, '-depsc2', 'Figures/fixed_regions.eps');
    
    
%     
%     %%
%     
%     plot(set_corpus.Lagged_FS.model.adjusted_losscs,'k')
%     hold on;
%     plot(set_corpus.Lagged_VS.model.adjusted_losscs,'r')
%     plot(set_corpus.Lagged_Sleeping.model.adjusted_losscs,'b')
%     title('eeru1206');
%     hold off;
%     grid on;
%     
%     %%
%     
%     plot(set_corpus.Variable_FS.model.adjusted_losscs,'k')
%     hold on;
%    % plot(set_corpus.Variable_VS.model.adjusted_losscs,'r')
%     plot(set_corpus.Variable_Sleeping.model.adjusted_losscs,'b')
%     title('eeru1206');
%     hold off;
%     grid on;
%     
%     %%
%     
%     plot(set_corpus.Ridge.model.adjusted_losscs,'k')
%     grid on;
    
end


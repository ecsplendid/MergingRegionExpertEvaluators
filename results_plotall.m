function [  ] = results_plotall( results_meta )
%RESULTS_PLOTALL Plot results
%%

    set_corpus = all.eeru1206;

    plot(set_corpus.Fixed_FS.model.adjusted_losscs,'k')
    hold on;
    plot(set_corpus.Fixed_VS.model.adjusted_losscs,'r')
    plot(set_corpus.Fixed_Sleeping.model.adjusted_losscs,'b')
    title('eeru1206');
    hold off;
    
    %%
    
    plot(set_corpus.Lagged_FS.model.adjusted_losscs,'k')
    hold on;
    plot(set_corpus.Lagged_VS.model.adjusted_losscs,'r')
    plot(set_corpus.Lagged_Sleeping.model.adjusted_losscs,'b')
    title('eeru1206');
    hold off;
    
    %%
    
    plot(set_corpus.Variable_FS.model.adjusted_losscs,'k')
    hold on;
    plot(set_corpus.Variable_VS.model.adjusted_losscs,'r')
    plot(set_corpus.Variable_Sleeping.model.adjusted_losscs,'b')
    title('eeru1206');
    hold off;

end


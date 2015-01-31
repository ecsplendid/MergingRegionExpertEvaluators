function [  ] = results_outputresults( results_meta )
%RESULTS_OUTPUTRESULTS take a results_meta object and give results
%%

ds = results_meta.rts307.Ridge;

[ ds.model.adjusted_losscs(end) median(ds.model.adjusted_losscs) ]


end


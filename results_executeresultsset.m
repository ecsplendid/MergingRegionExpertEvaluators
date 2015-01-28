function [ overall_results ] = results_executeresultsset( set_name )
%RESULTS_EXECUTERESULTSSET get an executed result set for every dataset and
%return it in a results_meta class

if nargin < 2
   skip = 1; 
end

overall_results = results_meta();
overall_results.eeru1206 = results_getset( set_name, 'eeru1206' );
overall_results.rts307 = results_getset( set_name, 'rts307' );
overall_results.gaz307 = results_getset( set_name, 'gaz307' );

end


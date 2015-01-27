function [ overall_results ] = results_executeresultsset( set_name )
%RESULTS_EXECUTERESULTSSET get an executed result set for every dataset and
%return it in a results_meta class

overall_results = results_meta();
overall_results.eeru1206 = results_getset( set_name, 'eeru1206', 1:10:13152 );
overall_results.rts307 = results_getset( set_name, 'rts307', 1:10:8410 );
overall_results.gaz307 = results_getset( set_name, 'gaz307', 1:10:10985 );

end


function [ region_map ] = GenerateRegionMap( region_count, region_width, dataset_size )
%GenerateRegionMap 
%   generate region_map which will look like this
%
%   [ 1 100;
%     210 310;
%     420 520; ...]
%
%   [ start1 end1; start2 end2; ...]
%
%   The regions can be over lapping depending on parameters

%%

%dataset_size = 10000;
%region_width = 100;
%region_count = 300;

starts = ceil( linspace(1, dataset_size - region_width, region_count) );
ends = starts + region_width-1;

region_map = [starts' ends'];


end


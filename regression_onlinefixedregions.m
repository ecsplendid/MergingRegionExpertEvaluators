function [preds, losses] = regression_onlinefixedregions( ...
    data, labels, kernel, ...
    window_size, ridge_coeff, ...
    num_expertevaluators )
%regression_onlinefixedregions
%return a matrix of expert evaulators issuing predictions after their
%underlying region has been fully revealed. 

preds = nan( size(data,2), num_expertevaluators );
losses = nan( size(data,2), num_expertevaluators );

region_indices = floor( ...
                    linspace( ...
                        1, size(data,2), num_expertevaluators+1 ...
                        ) );

for r=1:num_expertevaluators-1
    
    % note the first regions might get truncated if window_size >
    % size(data,2)/num_expertevaulators
    region = max(1,... 
        (region_indices(r+1)-window_size+1)...
        ):region_indices(r+1)-1;
    
    % might not be same as window_size for first ones
    region_size = min( length( region ), region_indices(r+1) );
    
    % upper triangle of kernel matrix
    K = nan(region_size,region_size);
    for i=1:region_size
        K(i,i:region_size) = ...
            kernel(data(:, region(i:region_size)), data(:,region(i)));
    end
 
    % here U is the chol factor of aI + K, where
    % K is the kernelmatrix of the window_size of the train region.
    U = chol(ridge_coeff * eye(region_size, region_size) ...
        + K);
    inv = (U \ (U' \ labels(region)'))';
        
    for t = region_indices(r+1):size(data,2)

        k = kernel(data(:,region),data(:,t));
        y = inv * k';
        
        preds( t, r ) = y;
        losses( t, r ) = (y-labels(t))^2;
    end
end

end%function
function [losses, preds, weights_saved] = merge_expertevaluators...
    (predictions_tri,outcomes,alpha, operating_mode)

% merge_expertevaluators(predictions_tri,outcomes,alpha,mode)
%implementation of the aggregrating algorithm/sleeping expert evaluators/
%fixed share/variable share algorithms
%operating_mode 0==AA,1=FS,2=VS
% applies region experts with the update rule based on sleeping experts and 
% fixed share each expert is regression based on the window of size windowSize,
% alpha is the switching probability
% takes a triangle of (losses) as input, NaNs in this
% triangle indicate the expert hasn't woken up yet example:
% can take any arbitrary nan/L configuration
% LNNN
% LLNN
% LLLN
% LLLL
% where L is a loss figure and N is a nan (expert still asleep) cols are
% experts, rows are expert predictions TOP LEFT orientation
% so this file is a simplification because it contains no semantics for 
% making the actual predictions, just for sleeping/FS/merging/
% switching/PWEA stuff

% the range of possible outcomes:
A = min(outcomes);
B = max(outcomes);

gamma=outcomes;

numExperts = size(predictions_tri,2);

expertsSoFar = numExperts; % number of experts revealed so far

% things for calculating the mixture
beta = exp(-2/((B-A)^2));
%beta = 0.05;

iterations = 1:size( predictions_tri, 1 );

numExperts = size( predictions_tri, 2 ); % the total number of experts
weights = ones(1,numExperts)/numExperts; % initial weights are 1/numExperts
weights_saved = nan(length(iterations),numExperts);

for t = iterations % master loop
    
    awake_expertindexes = ~isnan( predictions_tri( t, 1:expertsSoFar ) );
    
    expertsPredictions = predictions_tri(t, awake_expertindexes );
    
    expertsPredictions( expertsPredictions > B ) = B;
    expertsPredictions( expertsPredictions < A) = A;

    % our prediction
    gamma(t)= mixture(...
        expertsPredictions, weights(awake_expertindexes), A, B, beta);
    % we are using only the awake experts
    
    % weights update
    sleepingLoss = superprediction_loss( ...
        expertsPredictions, weights(awake_expertindexes), ...
        beta, outcomes(t) );

    allLosses = [(expertsPredictions-outcomes(t)).^2 ...
        repmat(sleepingLoss, 1, numExperts-length(expertsPredictions))];
    % predictions and losses of all experts including sleeping
    
    % standard AA loss update
    wstar = weights.*(beta.^(allLosses-sleepingLoss)); % wstar sums to one

    % fixed share weight update
    if operating_mode == 1
        
        weights = (1-alpha - alpha/(numExperts-1))*wstar + ...
            (alpha/(numExperts-1));
    end
    
    %variable share weight update
    if operating_mode == 2
            
        pool = wstar*(1-(1-alpha).^allLosses');
        weights = ((1-alpha).^allLosses).*wstar + ...
            (pool - (1 - (1-alpha).^allLosses).*wstar) / (numExperts-1);
    end
    
    %normalize
    weights = weights./sum(weights);
    
    %assert that weights add up to 1
	assert(abs(sum(weights)-1) < 1e-10);
    
    weights_saved(t,:) = [ weights(awake_expertindexes) ...
        zeros(1, numExperts-length(expertsPredictions))]...
        / sum(weights(awake_expertindexes) );
    
end % master loop ends

preds = gamma;
losses = (gamma-outcomes).^2;

end
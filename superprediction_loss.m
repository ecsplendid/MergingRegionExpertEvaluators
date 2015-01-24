function [spl] = superprediction_loss(expertsPredictions,weights,beta,outcome)
% this returns the superpreduction loss for the outcome

assert(all(size(expertsPredictions) == size(weights)));

losses = (expertsPredictions-outcome).^2;

spl = log((beta.^losses)*weights'/sum(weights))/log(beta);

assert( size(spl,1)==1 )
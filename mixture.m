function gamma = mixture(expertsPredictions,weights,A,B,beta);

% mixture(expertPredictions,weights,A,B,beta) merges expertsPredictions
% with weights in the square-loss game on [A, B] with the exponential
% learning rate beta
% the formula gamma = (g(B)-g(A))/(2(B-A))+(B+A)/2 is used

% sanity check: delete this if you are sure this works fine
if A>B
    error('YK mixture: the interval should be A..B')
end
% end of sanity check

lossesB = (expertsPredictions-B).^2;
lossesA = (expertsPredictions-A).^2;

gB = log(sum((beta.^lossesB).*weights)/sum(weights))/log(beta);
gA = log(sum((beta.^lossesA).*weights)/sum(weights))/log(beta);

gamma = (gA-gB)/(2*(B-A))+(B+A)/2;
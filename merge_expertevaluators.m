function [ diffs cums losses preds weights_saved ] = ...
    run_pwea( P, alpha, runmode, raw, labels, truncate_limit, window_size  )
%RUN_PWEA Summary of this function goes here
%   Detailed explanation goes here

    [losses preds weights_saved] = AA( P((window_size+1):end,:), ...
            labels(window_size+1:end), alpha, runmode);

       % imagesc(log(weights_saved(100:end-1000,:))')
       % axis xy

    %sum(losses)
    %imagesc(log(weights_saved))

    % bench mark score for this dataset

    competitor = raw(1:truncate_limit,11)./100;
    volatility = raw(1:truncate_limit,10);

    volatility= labels';

    complosses = (competitor - volatility).^2;

    difference = (losses - complosses((window_size+1):end)');

    cums = cumsum(difference);

    diffs = [ cums(6000) cums(end) ];

end


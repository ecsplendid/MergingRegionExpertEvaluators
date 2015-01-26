%% lagged region merging algorithm

model = region_model;
model.corpus_name = 'eeru1206';
model.selection= -1;
model.maxlag_timehorizon = 4000;
model.num_expertevaulators = 30;
model.window_size = 200;
mlag = execute_onlinelaggedexperts(model);
plot(mlag.adjusted_losscs);
grid on;
hold on;
%% fixed region merging algorithm

mfixed = execute_onlinefixedregions(model);
plot(mfixed.adjusted_losscs,'k');


%% on-line sliding ridge regression

mbasic = execute_onlinebasicregression(model);
plot(mbasic.adjusted_losscs,'r');
grid on;
hold off;

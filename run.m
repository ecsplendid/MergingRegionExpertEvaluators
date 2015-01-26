%% lagged region merging algorithm

model = region_model;
model.degree = 3;
model.ridge_coeff = 2;
model.window_size = 200;
model.corpus_name = 'eeru1206';
model.selection= -1; % 1:5000
model.maxlag_timehorizon = 4000;
model.num_expertevaluators = 20;
mlag = execute_onlinelaggedexperts(model);
model.alpha = 0.5;
plot(mlag.adjusted_losscs);
grid on;
hold on;

%% fixed region merging algorithm

model.num_expertevaluators = 200;
mfixed = execute_onlinefixedregions(model);
plot(mfixed.adjusted_losscs,'k');

%% on-line sliding ridge regression

model.num_expertevaluators = 20;
mbasic = execute_onlinebasicregression(model);
plot(mbasic.adjusted_losscs,'r');
grid on;

%% variable window size merged regression

model.window_sizeminimum = 30;
mvariable = execute_onlinevariablemergedregression( model )
plot(mvariable.adjusted_losscs,'g');

hold off;

%%

legend('Lagged Regions', 'Fixed Regions', 'Sliding Ridge Regression', 'Variable Window Merging')


%% lagged region merging algorithm

model = region_model;
model.corpus_name = 'eeru1206';
model.selection= -1;
model.maxlag_timehorizon = 1000;
model.num_expertevaulators = 10;
mlag = execute_onlinelaggedexperts(model);
plot(mlag.adjusted_losscs);
grid on;

%% fixed region merging algorithm

model = region_model;
model.corpus_name = 'eeru1206';
model.selection= 1:2000;
model.num_expertevaulators = 50;
model.window_size = 200;

m = execute_onlinefixedregions(model);
plot(m.adjusted_losscs,'k:');
grid on;

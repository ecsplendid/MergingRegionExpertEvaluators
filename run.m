
model = region_model;
model.corpus_name = 'gaz307';
model.selection= 4000:7000;
model.maxlag_timehorizon = 1000;
model.num_expertevaulators = 10;
m = execute_onlinelaggedexperts(model);
plot(m.adjusted_losscs);
grid on;

%% 

model = region_model;
model.corpus_name = 'eeru1206';
model.truncate = 6000;
model.num_expertevaulators = 30;

m = execute_onlinefixedregions(model);
plot(m.adjusted_losscs);
grid on;

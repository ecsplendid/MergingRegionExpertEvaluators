model = region_model;
model.corpus_name = 'eeru1206';
model.truncate = -1;
m = execute_onlinelaggedexperts(model);
plot(m.adjusted_losscs);
grid on;



%%

model = region_model;
model.corpus_name = 'eeru1206';
model.truncate = 6000;
model.num_expertevaulators = 20;

m = execute_onlinefixedregions(model);
plot(m.adjusted_losscs);
grid on;

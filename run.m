model = region_model;
model.corpus_name = 'rts307';
m = execute_regionsalgorithm(model);
plot(m.adjusted_losscs);
grid on;
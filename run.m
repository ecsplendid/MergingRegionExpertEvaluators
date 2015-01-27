%% lagged region merging algorithm

model = region_model;
model.degree = 7;
model.ridge_coeff = 8.82;
model.window_size = 268;
model.corpus_name = 'rts1206';
model.selection= 1:10:10126;
model.maxlag_timehorizon = 4000;
model.num_expertevaluators = 29;
model.alpha = 0.5891;
model.AA_mode = 2;

mlag = execute_onlinelaggedexperts(model);
plot(mlag.adjusted_losscs);
grid on;


%% fixed region merging algorithm
            
model = region_model;
model.corpus_name = 'eeru1206';
model.selection = -1;
model.window_size = 200;
model.ridge_coeff = 9.06;
model.num_expertevaluators = 200;
model.degree = 9;
model.alpha = 0.9;
model.AA_mode = 2;

%%
model.selection = -1;
mfixed = execute_onlinefixedregions(model);
plot(mfixed.adjusted_losscs,'k');
grid on;
%% on-line sliding ridge regression

model.corpus_name = 'eeru1206';
model.selection = -1;
model.degree=4;
model.window_size = 250;
model.ridge_coeff = 1;

mbasic = execute_onlinebasicregression(model);
plot(mbasic.adjusted_losscs,'r');
grid on;

%% variable window size merged regression

model.window_sizeminimum = 30;
mvariable = execute_onlinevariablemergedregression( model )
plot(mvariable.adjusted_losscs,'g');

hold off;

%% random param merged regression

model = region_model;
model.corpus_name = 'eeru1206';
model.degrees = 1:10;
model.window_sizes = 50:30:400;
model.ridges = 0.1:0.5:10;
model.selection = -1;
model.num_expertevaluators = 10;
model.alpha = 0.8; 
randmodel = execute_onlinerandommergedregression( model );
plot(randmodel.adjusted_losscs,'k:');

%%

legend( 'Lagged Regions', ...
    'Fixed Regions', ...
    'Sliding Ridge Regression', ...
    'Variable Window Merging')

%%

[ corpus, labels, competitor ] = get_corpus( ...
    'eeru1206', -1 );

length(labels)

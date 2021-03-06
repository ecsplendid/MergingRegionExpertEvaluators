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

model.selection = -1;
mfixed = execute_onlinefixedregions(model);
plot(mfixed.adjusted_losscs,'k');
grid on;

%% on-line sliding ridge regression

model.corpus_name = 'gaz307';
   
model.selection = -1;
model.degree = 7;
model.window_size = 355;
model.ridge_coeff = 7.6997;

hFig = figure(1);
set(hFig, 'Position', [600 1 400 400]);
mbasic = execute_onlinebasicregression(model);
plot(mbasic.adjusted_losscs,'k','LineWidth',2);
title( sprintf( 'Ridge regression on %s', model.corpus_name ) );
xlabel('Record Number');
ylabel('Cumulative Adjusted Deviation');
axis square;
grid on;
print(gcf, '-depsc2', ...
    sprintf(  'Figures/ridge_regression_%s.eps', model.corpus_name ) );


%% variable window size merged regression

model.window_sizeminimum = 30;
mvariable = execute_onlinevariablemergedregression( model )
plot(mvariable.adjusted_losscs,'g');

hold off;

%% merged random param merged regression (meta merging)

model = region_model;
model.window_size= 300;
model.AA_mode = 2;
model.num_expertevaluators = 119;
model.stack_count = 8;
model.alpha = 0.9901;

model.selection = -1;
model.corpus_name = 'gaz307';
load( sprintf( 'Data/PredMatrix/%s.mat', model.corpus_name ) );

[randstackedmodel] = ...
        execute_onlinemergedrandommergedregression...
        ( model, pred_matrix );

plot(randstackedmodel.adjusted_losscs,'r','LineWidth',2);
grid on
[ randstackedmodel.results_adjustedlosssum ...
    randstackedmodel.results_adjustedlossmedian ]

%% averaged random param merged regression

model = region_model;
model.corpus_name = 'rts307';
load( sprintf( 'Data/PredMatrix/%s.mat', model.corpus_name ) );
model.stack_count = 17;
model.alpha = 0.8647;
model.selection = -1;
model.num_expertevaluators = 40;
model.window_size = 400;

[randstackedmodel] = ...
        execute_onlineaveragerandommergedregression...
        ( model, pred_matrix );

plot(randstackedmodel.adjusted_losscs,'r','LineWidth',2);
grid on
[ randstackedmodel.results_adjustedlosssum ...
    randstackedmodel.results_adjustedlossmedian ]
    
%% random param merged regression

model = region_model;
model.corpus_name = 'rts307';
load( sprintf( 'Data/PredMatrix/%s.mat', model.corpus_name ) );

model.degrees = 1:7;
model.window_sizes = 50:30:250;
model.ridges = 0.1:0.1:10;
model.selection = -1;
model.num_expertevaluators = 150;
model.AA_mode = 2;
model.alpha = 0.7; 
rehash = 1;

[randmodel, first_prediction ] = ...
        execute_onlinerandommergedregression( model, pred_matrix );

plot(randmodel.adjusted_losscs,'r','LineWidth',2);


%%
hold on;
plot(avmodel.adjusted_losscs,'k','LineWidth',2);
plot(mbasic.adjusted_losscs,'b','LineWidth',2);
hold off;
grid on
title(model.corpus_name)
legend(...
    sprintf('Variable Share Merged Random Params Algorithm (%d)',model.num_expertevaluators), ...
    'Averaged Random Ridge Regression Models', ...
    'Optimized Sliding Ridge Regression');
%plot(randmodel.weights)

%%
model = region_model;
model.corpus_name = 'eeru1206';
model.selection = -1;
load( sprintf( 'Data/PredMatrix/%s.mat', model.corpus_name ) );

[ avmodel ] = execute_onlineaveragedregression( ...
    model, pred_matrix );

plot(avmodel.adjusted_losscs,'k','LineWidth',2);
grid on;

%%

legend( 'Lagged Regions', ...
    'Fixed Regions', ...
    'Sliding Ridge Regression', ...
    'Variable Window Merging')

%%

[ corpus, labels, competitor ] = get_corpus( ...
    'gaz307', -1 );

plot(labels)

%%

all = results_executeresultsset( 'Skip1_5Gen' );

%%

batch_generaterandompreds( 'eeru1206', 500 );
batch_generaterandompreds( 'gaz307', 500 );
batch_generaterandompreds( 'rts307', 500 );

%% merging lagged previous labels algorithm
% surpringly (or perhaps encouragingly), this performs terribly and isn't 
% worth bothering with, weird considering predicting the last record works
% so well

model = region_model;
model.corpus_name = 'rts307';
model.selection= -1;
model.maxlag_timehorizon = 40;
model.num_expertevaluators = 30;
model.alpha = 0.4;
model.AA_mode = 2;

mlaglabels = execute_onlinelaggedlabels(model);

plot(mlaglabels.adjusted_losscs);
grid on;

%% merged possible labels algorithm (pipe dream)

model = region_model;
model.corpus_name = 'eeru1206';
model.selection= -1;
model.alpha = 0.4;
model.AA_mode = 2;
model.label_min = 0;
model.label_max = 1;
model.num_expertevaluators = 100;

mlaglabels = execute_onlinepossiblelabels(model);

plot(mlaglabels.adjusted_losscs);
grid on;
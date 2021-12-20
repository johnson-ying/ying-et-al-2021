

clear
load('Analysis\s_fig19.mat')

%% plot 
j20_training_mean_young = nanmean(J20_training_young);
wt_training_mean_young = nanmean(WT_training_young);
j20_trialdark_mean_young = nanmean(J20_trial_dark_young);
wt_trialdark_mean_young = nanmean(WT_trial_dark_young);
j20_triallight_mean_young = nanmean(J20_trial_light_young);
wt_triallight_mean_young = nanmean(WT_trial_light_young);

j20_training_mean_old = nanmean(J20_training_old);
wt_training_mean_old = nanmean(WT_training_old);
j20_trialdark_mean_old = nanmean(J20_trial_dark_old);
wt_trialdark_mean_old = nanmean(WT_trial_dark_old);
j20_triallight_mean_old = nanmean(J20_trial_light_old);
wt_triallight_mean_old = nanmean(WT_trial_light_old);

%error bars for bar graph
a_sem = nanstd(J20_training_young)/sqrt(length(J20_training_young) - sum(isnan(J20_training_young)))
b_sem = nanstd(WT_training_young)/sqrt(length(WT_training_young) - sum(isnan(WT_training_young)))
c_sem = nanstd(J20_trial_dark_young)/sqrt(length(J20_trial_dark_young) - sum(isnan(J20_trial_dark_young)))
d_sem = nanstd(WT_trial_dark_young)/sqrt(length(WT_trial_dark_young) - sum(isnan(WT_trial_dark_young)))
e_sem = nanstd(J20_trial_light_young)/sqrt(length(J20_trial_light_young) - sum(isnan(J20_trial_light_young)))
f_sem = nanstd(WT_trial_light_young)/sqrt(length(WT_trial_light_young) - sum(isnan(WT_trial_light_young)))

aa_sem = nanstd(J20_training_old)/sqrt(length(J20_training_old) - sum(isnan(J20_training_old)))
bb_sem = nanstd(WT_training_old)/sqrt(length(WT_training_old) - sum(isnan(WT_training_old)))
cc_sem = nanstd(J20_trial_dark_old)/sqrt(length(J20_trial_dark_old) - sum(isnan(J20_trial_dark_old)))
dd_sem = nanstd(WT_trial_dark_old)/sqrt(length(WT_trial_dark_old) - sum(isnan(WT_trial_dark_old)))
ee_sem = nanstd(J20_trial_light_old)/sqrt(length(J20_trial_light_old) - sum(isnan(J20_trial_light_old)))
ff_sem = nanstd(WT_trial_light_old)/sqrt(length(WT_trial_light_old) - sum(isnan(WT_trial_light_old)))

meanvalues = [wt_trialdark_mean_young; wt_triallight_mean_young; wt_trialdark_mean_old; wt_triallight_mean_old; j20_trialdark_mean_young; j20_triallight_mean_young; j20_trialdark_mean_old; j20_triallight_mean_old] ;
E = [d_sem; f_sem; dd_sem; ff_sem; c_sem; e_sem; cc_sem; ff_sem];
figure
hold on
bar(meanvalues, 'BarWidth',1)
set(gca,'FontName','Calibri','FontSize',14)
set(gcf, 'color', [1 1 1])
set(gca, 'color', [1 1 1])
grid off
box off


% Finding the number of groups and the number of bars in each group
ngroups = size(meanvalues, 1);
nbars = size(meanvalues, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, meanvalues(:,i), E(:,i), 'k', 'linestyle', 'none');
end

hold on
scatter(linspace(.85,.85,size(WT_trial_dark_young,1)), WT_trial_dark_young, 'k', 'filled')
hold on
scatter(linspace(1.85,1.85,size(WT_trial_light_young,1)), WT_trial_light_young, 'r', 'filled')
hold on
scatter(linspace(2.85,2.85,size(WT_trial_dark_old,1)), WT_trial_dark_old, 'b', 'filled')
hold on
scatter(linspace(3.85,3.85,size(WT_trial_light_old,1)), WT_trial_light_old, 'g', 'filled')
hold on
scatter(linspace(4.85,4.85,size(J20_trial_dark_young,1)), J20_trial_dark_young, 'y', 'filled')
hold on
scatter(linspace(5.85,5.85,size(J20_trial_light_young,1)), J20_trial_light_young, 'c', 'filled')
hold on
scatter(linspace(6.85,6.85,size(J20_trial_dark_old,1)), J20_trial_dark_old, 'm', 'filled')
hold on
scatter(linspace(7.85,7.85,size(J20_trial_light_old,1)), J20_trial_light_old, 'o', 'filled')
hold on
ylim([1,9])

%% 2-sided wilcoxin rank sum test

ranksum(WT_trial_dark_young, WT_trial_light_young)
ranksum(WT_trial_dark_old,WT_trial_light_old)
ranksum(J20_trial_dark_young, J20_trial_light_young)
ranksum(J20_trial_dark_old, J20_trial_light_old)


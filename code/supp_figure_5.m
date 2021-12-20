
clear
load('Analysis\s_fig5.mat')

%% Fig.S5a
wty = WTy_CollectISIviolate';
wta = WTo_CollectISIviolate';
j20y = J20y_CollectISIviolate';
j20a = J20o_CollectISIviolate';

figure
cdfplot(wty)
hold on
cdfplot(wta)
hold on
cdfplot(j20y)
hold on
cdfplot(j20a)
axis square
xlim([0, 0.05])

%bar plot
wty_med = nanmedian(wty)
wto_med = nanmedian(wta)
j20y_med = nanmedian(j20y)
j20o_med = nanmedian(j20a)

wty25 = prctile(wty,25)
wty75 = prctile(wty,75)
wto25 = prctile(wta,25)
wto75 = prctile(wta,75)
j20y25 = prctile(j20y,25)
j20y75 = prctile(j20y,75)
j20o25 = prctile(j20a,25)
j20o75 = prctile(j20a,75)

medianvalues = [wty_med;wto_med;j20y_med;j20o_med];

figure
bar(medianvalues,'k', 'FaceAlpha',0.2)
hold on
line([1 1], [wty25 wty75]);
hold on
line([2 2], [wto25 wto75]);
hold on
line([3 3], [j20y25 j20y75]);
hold on
line([4 4], [j20o25 j20o75]);
hold on
scatter(linspace(.85,.85,size(wty,1)), wty, 'k', 'filled')
hold on
scatter(linspace(1.85,1.85,size(wta,1)), wta, 'r', 'filled')
hold on
scatter(linspace(2.85,2.85,size(j20y,1)), j20y, 'b', 'filled')
hold on
scatter(linspace(3.85,3.85,size(j20a,1)), j20a, 'g', 'filled')
axis square
box off
grid off

%% Fig.S5b
wty = WTy_CollectSepInd';
wta = WTo_CollectSepInd';
j20y = J20y_CollectSepInd';
j20a = J20o_CollectSepInd';

%cdf
figure
cdfplot(wty)
hold on
cdfplot(wta)
hold on
cdfplot(j20y)
hold on
cdfplot(j20a)
axis square
xlim([0, 200])

%bar plot
wty_med = nanmedian(wty)
wto_med = nanmedian(wta)
j20y_med = nanmedian(j20y)
j20o_med = nanmedian(j20a)

wty25 = prctile(wty,25)
wty75 = prctile(wty,75)
wto25 = prctile(wta,25)
wto75 = prctile(wta,75)
j20y25 = prctile(j20y,25)
j20y75 = prctile(j20y,75)
j20o25 = prctile(j20a,25)
j20o75 = prctile(j20a,75)

medianvalues = [wty_med;wto_med;j20y_med;j20o_med];

figure
bar(medianvalues,'k', 'FaceAlpha',0.2)
hold on
line([1 1], [wty25 wty75]);
hold on
line([2 2], [wto25 wto75]);
hold on
line([3 3], [j20y25 j20y75]);
hold on
line([4 4], [j20o25 j20o75]);
hold on
scatter(linspace(.85,.85,size(wty,1)), wty, 'k', 'filled')
hold on
scatter(linspace(1.85,1.85,size(wta,1)), wta, 'r', 'filled')
hold on
scatter(linspace(2.85,2.85,size(j20y,1)), j20y, 'b', 'filled')
hold on
scatter(linspace(3.85,3.85,size(j20a,1)), j20a, 'g', 'filled')
axis square
box off
grid off
ylim([0 200])

%% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

ranksum(wty, wta)
ranksum(wty,j20y)
ranksum(j20y, j20a)
ranksum(wta, j20a)




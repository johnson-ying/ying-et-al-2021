
clear
load('Analysis\s_fig20.mat')

%% Fig.S20
wty = Initial_Wall_Angle{1,1}
wta = Initial_Wall_Angle{1,2}
j20y = Initial_Wall_Angle{1,3}
j20a = Initial_Wall_Angle{1,4}

wty = Initial_Heading_Angle{1,1}
wta = Initial_Heading_Angle{1,2}
j20y = Initial_Heading_Angle{1,3}
j20a = Initial_Heading_Angle{1,4}

wty = Normalized_Dist_Travelled{1,1}
wta = Normalized_Dist_Travelled{1,2}
j20y = Normalized_Dist_Travelled{1,3}
j20a = Normalized_Dist_Travelled{1,4}

wty = Proportion_Path_Along_Walls{1,1}
wta = Proportion_Path_Along_Walls{1,2}
j20y = Proportion_Path_Along_Walls{1,3}
j20a = Proportion_Path_Along_Walls{1,4}


%% plotting

%cdf plot
figure
cdfplot(wty)
hold on
cdfplot(wta)
hold on
cdfplot(j20y)
hold on
cdfplot(j20a)
axis square

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

%% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

ranksum(wty, wta)
ranksum(wty,j20y)
ranksum(j20y, j20a)
ranksum(wta, j20a)






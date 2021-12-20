
clear
load('Analysis\fig4.mat')

%% Fig.4c

wty = Grid_HD_Synchrony{1,1}
wta = Grid_HD_Synchrony{1,2}
j20y = Grid_HD_Synchrony{1,3}
j20a = Grid_HD_Synchrony{1,4}

wty = Grid_Interneuron_Synchrony{1,1}
wta = Grid_Interneuron_Synchrony{1,2}
j20y = Grid_Interneuron_Synchrony{1,3}
j20a = Grid_Interneuron_Synchrony{1,4}

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


%% 2-way ANOVA for synchrony 

metric = [wty;wta;j20y;j20a];

sizeWTy = size(wty); sizeWTy = sizeWTy(1,1);
sizeWTa = size(wta); sizeWTa = sizeWTa(1,1);
sizeJ20y = size(j20y); sizeJ20y = sizeJ20y(1,1);
sizeJ20a = size(j20a); sizeJ20a = sizeJ20a(1,1);

A = repmat('young',sizeWTy,1);
B = repmat('aged ',sizeWTa,1);
C = repmat('young',sizeJ20y,1);
D = repmat('aged ',sizeJ20a,1);

Ages =[A;B;C;D];

A = repmat('b_nTG',sizeWTy,1);
B = repmat('b_nTG',sizeWTa,1);
C = repmat('a_J20',sizeJ20y,1);
D = repmat('a_J20',sizeJ20a,1);

Genotype2 =[A;B;C;D];

[p,tbl,stats] = anovan(metric,{Ages Genotype2},'model',2,'varnames',{'Age','Genotype'})






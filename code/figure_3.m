
clear
load('Analysis\fig3.mat')

%% Fig.3a
wty = Fig3a{1, 1}  
wta = Fig3a{1, 2}  
j20y = Fig3a{1, 3}  
j20a = Fig3a{1, 4}  

%% Fig.3d
wty = Fig3d_grid{1, 1}  
wta = Fig3d_grid{1, 2}  
j20y = Fig3d_grid{1, 3}  
j20a = Fig3d_grid{1, 4}  

wty = Fig3d_nongrid{1, 1}  
wta = Fig3d_nongrid{1, 2}  
j20y = Fig3d_nongrid{1, 3}  
j20a = Fig3d_nongrid{1, 4}  

wta = Fig3d_place{1, 1}  
j20a = Fig3d_place{1, 2}  

%% Fig.3e
wty = Fig3e{1, 1}  
wta = Fig3e{1, 2}  
j20y = Fig3e{1, 3}  
j20a = Fig3e{1, 4}  

%% plotting for grid and non grid spatial cells 

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

%% plotting for place cell

%cdf plot
figure
cdfplot(wta)
hold on
cdfplot(j20a)
axis square

%bar plot
wto_med = nanmedian(wta)
j20o_med = nanmedian(j20a)

wto25 = prctile(wta,25)
wto75 = prctile(wta,75)
j20o25 = prctile(j20a,25)
j20o75 = prctile(j20a,75)

medianvalues = [wto_med;j20o_med];

figure
bar(medianvalues,'k', 'FaceAlpha',0.2)
hold on
line([1 1], [wto25 wto75]);
hold on
line([2 2], [j20o25 j20o75]);
axis square
box off
grid off
% ylim([-50, 400])
hold on
scatter(linspace(.85,.85,size(wta,1)), wta, 'r', 'filled')
hold on
scatter(linspace(1.85,1.85,size(j20a,1)), j20a, 'g', 'filled')


%% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

ranksum(wty, wta)
ranksum(wty,j20y)
ranksum(j20y, j20a)
ranksum(wta, j20a)


%% 2-way ANOVA to compare stability between groups 

wty = GridScore{1, 1}  
wta = GridScore{1, 2}  
j20y = GridScore{1, 3}  
j20a = GridScore{1, 4}  

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

%% Fig. 2c - individual 2D displacement by individual lag

%Grid cells 

%calculate means 
wtymean = nanmean(Fig3c_grid{1,1}, 1)
wtamean = nanmean(Fig3c_grid{1,2}, 1)
j20ymean = nanmean(Fig3c_grid{1,3}, 1)
j20amean = nanmean(Fig3c_grid{1,4}, 1)

%calculate SEMs
wtyerror = nanstd(Fig3c_grid{1,1},1)/sqrt(length(Fig3c_grid{1,1}) - sum(isnan(Fig3c_grid{1,1}(:,1))) );
wtaerror = nanstd(Fig3c_grid{1,2},1)/sqrt(length(Fig3c_grid{1,2}) - sum(isnan(Fig3c_grid{1,2}(:,1))) );
j20yerror = nanstd(Fig3c_grid{1,3},1)/sqrt(length(Fig3c_grid{1,3}) - sum(isnan(Fig3c_grid{1,3}(:,1))) );
j20aerror = nanstd(Fig3c_grid{1,4},1)/sqrt(length(Fig3c_grid{1,4}) - sum(isnan(Fig3c_grid{1,4}(:,1))) );

figure 
errorbar(wtymean,wtyerror,'r')
hold on 
errorbar(wtamean,wtaerror,'k')
hold on 
errorbar(j20ymean,j20yerror,'c')
hold on 
errorbar(j20amean,j20aerror,'b')
hold on 
xlim([0 10])
hold on 
ylim([3 10])

%Non grid spatial cells 

%calculate means 
wtymean = nanmean(Fig3c_nongrid{1,1}, 1)
wtamean = nanmean(Fig3c_nongrid{1,2}, 1)
j20ymean = nanmean(Fig3c_nongrid{1,3}, 1)
j20amean = nanmean(Fig3c_nongrid{1,4}, 1)

%calculate SEMs
wtyerror = nanstd(Fig3c_nongrid{1,1},1)/sqrt(length(Fig3c_nongrid{1,1}) - sum(isnan(Fig3c_nongrid{1,1}(:,1))) );
wtaerror = nanstd(Fig3c_nongrid{1,2},1)/sqrt(length(Fig3c_nongrid{1,2}) - sum(isnan(Fig3c_nongrid{1,2}(:,1))) );
j20yerror = nanstd(Fig3c_nongrid{1,3},1)/sqrt(length(Fig3c_nongrid{1,3}) - sum(isnan(Fig3c_nongrid{1,3}(:,1))) );
j20aerror = nanstd(Fig3c_nongrid{1,4},1)/sqrt(length(Fig3c_nongrid{1,4}) - sum(isnan(Fig3c_nongrid{1,4}(:,1))) );

figure 
errorbar(wtymean,wtyerror,'r')
hold on 
errorbar(wtamean,wtaerror,'k')
hold on 
errorbar(j20ymean,j20yerror,'c')
hold on 
errorbar(j20amean,j20aerror,'b')
hold on 
xlim([0 10])
hold on 
ylim([3 10])


%Place cells 

%calculate means 
wtamean = nanmean(Fig3c_place{1,1}, 1)
j20amean = nanmean(Fig3c_place{1,2}, 1)

%calculate SEMs
wtaerror = nanstd(Fig3c_nongrid{1,1},1)/sqrt(length(Fig3c_nongrid{1,1}) - sum(isnan(Fig3c_nongrid{1,1}(:,1))) );
j20aerror = nanstd(Fig3c_nongrid{1,2},1)/sqrt(length(Fig3c_nongrid{1,2}) - sum(isnan(Fig3c_nongrid{1,2}(:,1))) );

figure 
errorbar(wtamean,wtaerror,'k')
hold on 
errorbar(j20amean,j20aerror,'b')
hold on 
xlim([0 10])
hold on 
ylim([3 10])











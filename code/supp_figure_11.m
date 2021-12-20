
clear
load('Analysis\s_fig11.mat')

%Loads a separate list for each group that contains speed-firing rate corr. (col.1), 
%mean resultant length scores (col.2), and grid scores (col.3)

%% Fig.S11a

%plot CDFs
for i = 1:9
    thres = i*0.1;
    
    wtymean = wtylist(wtylist(:,1)>thres);
    wtamean = wtalist(wtalist(:,1)>thres);
    j20ymean = j20ylist(j20ylist(:,1)>thres);
    j20amean = j20alist(j20alist(:,1)>thres);
    
    subplot(3,3,i)
    cdfplot(wtymean)
    hold on
    cdfplot(wtamean)
    hold on
    cdfplot(j20ymean)
    hold on
    cdfplot(j20amean)
    hold on 
    set(gca, 'XTick', thres:(1-thres)/2:1);
    set(gca, 'YTick', 0:0.5:1);
    xlim([thres 1])
    axis square
    grid off 
    box off
end


%plot bars
for i = 1:9
    thres = i*0.1;
    
    wtymean = wtylist(wtylist(:,1)>thres);
    wtamean = wtalist(wtalist(:,1)>thres);
    j20ymean = j20ylist(j20ylist(:,1)>thres);
    j20amean = j20alist(j20alist(:,1)>thres);
    
    wty_med = nanmedian(wtymean)
    wto_med = nanmedian(wtamean)
    j20y_med = nanmedian(j20ymean)
    j20o_med = nanmedian(j20amean)
    
    wty25 = prctile(wtymean,25)
    wty75 = prctile(wtymean,75)
    
    wto25 = prctile(wtamean,25)
    wto75 = prctile(wtamean,75)
    
    j20y25 = prctile(j20ymean,25)
    j20y75 = prctile(j20ymean,75)
    
    j20o25 = prctile(j20amean,25)
    j20o75 = prctile(j20amean,75)
    
    medianvalues = [wty_med;wto_med;j20y_med;j20o_med];
    
    subplot(3,3,i)
    bar(medianvalues,'k')
    hold on
    line([1 1], [wty25 wty75]);
    hold on
    line([2 2], [wto25 wto75]);
    hold on
    line([3 3], [j20y25 j20y75]);
    hold on
    line([4 4], [j20o25 j20o75]);
    axis square
    ylim([0 1])
    set(gca, 'YTick', 0:0.5:1);
    box off
    grid off
    hold on
    scatter(linspace(.85,.85,size(wtymean,1)), wtymean, 'k', 'filled')
    hold on
    scatter(linspace(1.85,1.85,size(wtamean,1)), wtamean, 'r', 'filled')
    hold on
    scatter(linspace(2.85,2.85,size(j20ymean,1)), j20ymean, 'b', 'filled')
    hold on
    scatter(linspace(3.85,3.85,size(j20amean,1)), j20amean, 'g', 'filled')
end

%% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

%pick threshold of interest
thres = 0.1;
thres = 0.2;
thres = 0.3;
thres = 0.4;
thres = 0.5;
thres = 0.6;
thres = 0.7;
thres = 0.8;
thres = 0.9;

%filter cells based on threshold
wtymean = wty_grid(wty_grid(:,1)>thres);
wtamean = wta_grid(wta_grid(:,1)>thres);
j20ymean = j20y_grid(j20y_grid(:,1)>thres);
j20amean = j20a_grid(j20a_grid(:,1)>thres);

%stat tests
ranksum(wtymean,wtamean)
ranksum(wtymean,j20ymean)
ranksum(j20ymean,j20amean)
ranksum(wtamean,j20amean)

%% Fig.S11b
wty = Grid_velrate{1, 1}  
wta = Grid_velrate{1, 2}  
j20y = Grid_velrate{1, 3}  
j20a = Grid_velrate{1, 4}  

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

% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

ranksum(wty, wta)
ranksum(wty,j20y)
ranksum(j20y, j20a)
ranksum(wta, j20a)


%% Fig.S11c
%2-way ANOVA for grid cell's speed vs. firing rate correlation

wty = Grid_velrate{1, 1}  
wta = Grid_velrate{1, 2}  
j20y = Grid_velrate{1, 3}  
j20a = Grid_velrate{1, 4}  

grid = [wty;wta;j20y;j20a];

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

[p,tbl,stats] = anovan(grid,{Ages Genotype2},'model',2,'varnames',{'Age','Genotype'})






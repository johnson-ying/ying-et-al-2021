
clear
load('Analysis\fig2.mat')

%% Fig.2a
wty = HD_MRL{1, 1}  
wta = HD_MRL{1, 2}  
j20y = HD_MRL{1, 3}  
j20a = HD_MRL{1, 4}  

wty = HD_PeakFiring{1, 1}  
wta = HD_PeakFiring{1, 2}  
j20y = HD_PeakFiring{1, 3}  
j20a = HD_PeakFiring{1, 4}  

wty = HD_MeanFiring{1, 1}  
wta = HD_MeanFiring{1, 2}  
j20y = HD_MeanFiring{1, 3}  
j20a = HD_MeanFiring{1, 4}  

%% Fig.2b
wty = NG_FieldSize{1, 1}  
wta = NG_FieldSize{1, 2}  
j20y = NG_FieldSize{1, 3}  
j20a = NG_FieldSize{1, 4}  

wty = NG_PeakFiring{1, 1}  
wta = NG_PeakFiring{1, 2}  
j20y = NG_PeakFiring{1, 3}  
j20a = NG_PeakFiring{1, 4}  

wty = NG_MeanFiring{1, 1}  
wta = NG_MeanFiring{1, 2}  
j20y = NG_MeanFiring{1, 3}  
j20a = NG_MeanFiring{1, 4}  

%% Fig. 2c
wta = Place_SptInfo{1, 1}  
j20a = Place_SptInfo{1, 2}  

wta = Place_PeakFiring{1, 1}  
j20a = Place_PeakFiring{1, 2}  

wta = Place_MeanFiring{1, 1}  
j20a = Place_MeanFiring{1, 2}   


%% plotting for HD or non grid spatial cell

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


%% 2-way ANOVA for any metric

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

%% Fig.2d

%0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 1}  
j20a = SptInfs_across_peak.J20o_All{1, 1}  

wta = AveRates_across_peak.WTo_All{1, 1}  
j20a = AveRates_across_peak.J20o_All{1, 1}  

%0.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 2}  
j20a = SptInfs_across_peak.J20o_All{1, 2}  

wta = AveRates_across_peak.WTo_All{1, 2}  
j20a = AveRates_across_peak.J20o_All{1, 2}  

%1.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 3}  
j20a = SptInfs_across_peak.J20o_All{1, 3}  

wta = AveRates_across_peak.WTo_All{1, 3}  
j20a = AveRates_across_peak.J20o_All{1, 3}  

%1.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 4}  
j20a = SptInfs_across_peak.J20o_All{1, 4}  

wta = AveRates_across_peak.WTo_All{1, 4}  
j20a = AveRates_across_peak.J20o_All{1, 4}  

%2.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 5}  
j20a = SptInfs_across_peak.J20o_All{1, 5}  

wta = AveRates_across_peak.WTo_All{1, 5}  
j20a = AveRates_across_peak.J20o_All{1, 5}  

%2.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 6}  
j20a = SptInfs_across_peak.J20o_All{1, 6}  

wta = AveRates_across_peak.WTo_All{1, 6}  
j20a = AveRates_across_peak.J20o_All{1, 6}  

%3.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 7}  
j20a = SptInfs_across_peak.J20o_All{1, 7}  

wta = AveRates_across_peak.WTo_All{1, 7}  
j20a = AveRates_across_peak.J20o_All{1, 7}  


%3.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 8}  
j20a = SptInfs_across_peak.J20o_All{1, 8}  

wta = AveRates_across_peak.WTo_All{1, 8}  
j20a = AveRates_across_peak.J20o_All{1, 8}  

%4.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 9}  
j20a = SptInfs_across_peak.J20o_All{1, 9}  

wta = AveRates_across_peak.WTo_All{1, 9}  
j20a = AveRates_across_peak.J20o_All{1, 9}  

%4.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 10}  
j20a = SptInfs_across_peak.J20o_All{1, 10}  

wta = AveRates_across_peak.WTo_All{1, 10}  
j20a = AveRates_across_peak.J20o_All{1, 10}  

%5.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 11}  
j20a = SptInfs_across_peak.J20o_All{1, 11}  

wta = AveRates_across_peak.WTo_All{1, 11}  
j20a = AveRates_across_peak.J20o_All{1, 11}  

%5.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 12}  
j20a = SptInfs_across_peak.J20o_All{1, 12}  

wta = AveRates_across_peak.WTo_All{1, 12}  
j20a = AveRates_across_peak.J20o_All{1, 12}  

%6.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 13}  
j20a = SptInfs_across_peak.J20o_All{1, 13}  

wta = AveRates_across_peak.WTo_All{1, 13}  
j20a = AveRates_across_peak.J20o_All{1, 13}  

%6.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 14}  
j20a = SptInfs_across_peak.J20o_All{1, 14}  

wta = AveRates_across_peak.WTo_All{1, 14}  
j20a = AveRates_across_peak.J20o_All{1, 14}  

%7.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 15}  
j20a = SptInfs_across_peak.J20o_All{1, 15}  

wta = AveRates_across_peak.WTo_All{1, 15}  
j20a = AveRates_across_peak.J20o_All{1, 15}  

%7.5 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 16}  
j20a = SptInfs_across_peak.J20o_All{1, 16}  

wta = AveRates_across_peak.WTo_All{1, 16}  
j20a = AveRates_across_peak.J20o_All{1, 16}  

%8.0 Hz peak threshold
wta = SptInfs_across_peak.WTo_All{1, 17}  
j20a = SptInfs_across_peak.J20o_All{1, 17}  

wta = AveRates_across_peak.WTo_All{1, 17}  
j20a = AveRates_across_peak.J20o_All{1, 17}  

%ranksum test
ranksum(wta, j20a)

%box plots for spatial information
x_wt = [];
c_wt = [];
for i=1:17
    x_wt = [x_wt; SptInfs_across_peak.WTo_All{1,i}];
    c_wt = [c_wt; i*ones(size(SptInfs_across_peak.WTo_All{1,i}))];
end

x_j20 = [];
c_j20 = [];
for i=1:17
    x_j20 = [x_j20; SptInfs_across_peak.J20o_All{1,i}];
    c_j20 = [c_j20; i*ones(size(SptInfs_across_peak.J20o_All{1,i})) + 0.5];
end

x = [x_wt;x_j20];
c = [c_wt;c_j20];

boxplot(x,c,'PlotStyle','compact','symbol', '')
ylim([0,6])

%box plots for mean firing rate
x_wt = [];
c_wt = [];
for i=1:17
    x_wt = [x_wt; AveRates_across_peak.WTo_All{1,i}];
    c_wt = [c_wt; i*ones(size(AveRates_across_peak.WTo_All{1,i}))];
end

x_j20 = [];
c_j20 = [];
for i=1:17
    x_j20 = [x_j20; AveRates_across_peak.J20o_All{1,i}];
    c_j20 = [c_j20; i*ones(size(AveRates_across_peak.J20o_All{1,i})) + 0.5];
end

x = [x_wt;x_j20];
c = [c_wt;c_j20];

boxplot(x,c,'PlotStyle','compact','symbol', '')
ylim([0,5])

%% Fig.2e
% ANCOVA

% Loaded data will be in the form of trial (rows) x running speeds (columns)

% Frequency
% J20y J20o
y = [J20y_PeakFreq(:); J20o_PeakFreq(:)];
x = [];
for i = 1:length(y)/35
    x = [x; (1:35)'];
end
group = [zeros(size(J20y_PeakFreq,1)*35,1); ones(size(J20o_PeakFreq,1)*35,1) ];
aoctool(x,y,group)


% J20y J20o 
y = [nanmean(J20y_PeakFreq) nanmean(J20o_PeakFreq)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)
              


% WTo J20o REPORTED SIG
y = [nanmean(WTo_PeakFreq) nanmean(J20o_PeakFreq)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)


% WTy J20y REPORTED SIG
y = [nanmean(WTy_PeakFreq) nanmean(J20y_PeakFreq)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)
                                

% WTy WTo
y = [nanmean(WTy_PeakFreq) nanmean(WTo_PeakFreq)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)
                 
 



% Power
% J20y J20o REPORTED NOT SIG
y = [nanmean(J20y_MeanPower) nanmean(J20o_MeanPower)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)
                           

% WTo J20o REPORTED NOT SIG
y = [nanmean(WTo_MeanPower) nanmean(J20o_MeanPower)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)
                        

% WTy J20y 
y = [nanmean(WTy_MeanPower) nanmean(J20y_MeanPower)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)

% WTy WTo
y = [nanmean(WTy_MeanPower) nanmean(WTo_MeanPower)];
x = [1:35 1:35];
group = [zeros(1,35) ones(1,35)];
aoctool(x,y,group)
              

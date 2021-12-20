
clear
load('Analysis\s_fig21.mat')

%% Fig.S21a
wty = MEC_VGLUT1{1, 1}  
wta = MEC_VGLUT1{1, 2}  
j20y = MEC_VGLUT1{1, 3}  
j20a = MEC_VGLUT1{1, 4}  

wty = MEC_VGLUT3{1, 1}  
wta = MEC_VGLUT3{1, 2}  
j20y = MEC_VGLUT3{1, 3}  
j20a = MEC_VGLUT3{1, 4}  

wty = MEC_VACHT{1, 1}  
wta = MEC_VACHT{1, 2}  
j20y = MEC_VACHT{1, 3}  
j20a = MEC_VACHT{1, 4}  

wty = MEC_VGAT{1, 1}  
wta = MEC_VGAT{1, 2}  
j20y = MEC_VGAT{1, 3}  
j20a = MEC_VGAT{1, 4}  

wty = MEC_NR1{1, 1}  
wta = MEC_NR1{1, 2}  
j20y = MEC_NR1{1, 3}  
j20a = MEC_NR1{1, 4}  

%% Fig.S21b
wty = CA1_VGLUT1{1, 1}  
wta = CA1_VGLUT1{1, 2}  
j20y = CA1_VGLUT1{1, 3}  
j20a = CA1_VGLUT1{1, 4}  

wty = CA1_VGLUT3{1, 1}  
wta = CA1_VGLUT3{1, 2}  
j20y = CA1_VGLUT3{1, 3}  
j20a = CA1_VGLUT3{1, 4}  

wty = CA1_VACHT{1, 1}  
wta = CA1_VACHT{1, 2}  
j20y = CA1_VACHT{1, 3}  
j20a = CA1_VACHT{1, 4}  

wty = CA1_VGAT{1, 1}  
wta = CA1_VGAT{1, 2}  
j20y = CA1_VGAT{1, 3}  
j20a = CA1_VGAT{1, 4}  

wty = CA1_NR1{1, 1}  
wta = CA1_NR1{1, 2}  
j20y = CA1_NR1{1, 3}  
j20a = CA1_NR1{1, 4}  


%% plotting

%cdf plot 
cdfplot(wty)
hold on
cdfplot(wta)
hold on
cdfplot(j20y)
hold on
cdfplot(j20a)
hold on
axis square


meanvalues = [nanmean(wty) nanmean(wta) nanmean(j20y) nanmean(j20a)];

a = nanstd(wty)/sqrt(length(wty) - sum(isnan(wty)));
b = nanstd(wta)/sqrt(length(wta) - sum(isnan(wta)));
c = nanstd(j20y)/sqrt(length(j20y) - sum(isnan(j20y)));
d = nanstd(j20a)/sqrt(length(j20a) - sum(isnan(j20a)));

E = [a b c d];

b = bar(meanvalues,'BarWidth',1)
ylabel('Signal Intensity')
set(gca,'FontName','Calibri','FontSize',14,'XTick',1:4,'XTickLabels',{'nTG-y','nTG-a','J20-y','J20-a'})
set(gcf, 'color', [1 1 1])
set(gca, 'color', [1 1 1])
hold on
errorbar([1,2,3,4],meanvalues,E,'vertical')
grid off
box off
hold on
scatter(ones(1,length(wty))-0.15,wty)
hold on
scatter(ones(1,length(wta))+1-0.15,wta)
hold on
scatter(ones(1,length(j20y))+2-0.15,j20y)
hold on
scatter(ones(1,length(j20a))+3-0.15,j20a)
% ylim([0,175])
set(gcf, 'Position',  [100, 100, 375, 425])


%% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

ranksum(wty, wta)
ranksum(wty,j20y)
ranksum(j20y, j20a)
ranksum(wta, j20a)


%% 2-way ANOVA for any intensity 

intensity = [wty;wta;j20y;j20a];

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

[p,tbl,stats] = anovan(intensity,{Ages Genotype2},'model',2,'varnames',{'Age','Genotype'})






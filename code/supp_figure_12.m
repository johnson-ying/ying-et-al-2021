
clear
load('Analysis\s_fig12.mat')

%% 2-way ANOVA on cell type x genotype for mean 2D displacement scores 
%given that place cells were only recorded in aged mice, there won't be any
%main factor of Age

displacements = [gc_wta;gc_j20a;ng_wta;ng_j20a;pc_wta;pc_j20a];

sizeGCwta = size(gc_wta); sizeGCwta = sizeGCwta(1,1);
sizeGCj20a = size(gc_j20a); sizeGCj20a = sizeGCj20a(1,1);
sizeNGwta = size(ng_wta); sizeNGwta = sizeNGwta(1,1);
sizeNGj20a = size(ng_j20a); sizeNGj20a = sizeNGj20a(1,1);
sizePCwta = size(pc_wta); sizePCwta = sizePCwta(1,1);
sizePCj20a = size(pc_j20a); sizePCj20a = sizePCj20a(1,1);

A = repmat('WT ',sizeGCwta,1);
B = repmat('APP',sizeGCj20a,1);
C = repmat('WT ',sizeNGwta,1);
D = repmat('APP',sizeNGj20a,1);
E = repmat('WT ',sizePCwta,1);
F = repmat('APP',sizePCj20a,1);

Pathology =[A;B;C;D;E;F];

A = repmat('Grid   ',sizeGCwta,1);
B = repmat('Grid   ',sizeGCj20a,1);
C = repmat('NonGrid',sizeNGwta,1);
D = repmat('NonGrid',sizeNGj20a,1);
E = repmat('Place  ',sizePCwta,1);
F = repmat('Place  ',sizePCj20a,1);

Celltype =[A;B;C;D;E;F];

[p,tbl,stats] = anovan(displacements,{Pathology Celltype},'model',2,'varnames',{'Pathology','Celltype'})

%Tukey's pairwise
multcompare(stats,'Dimension',[1 2])


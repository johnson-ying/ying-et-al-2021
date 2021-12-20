
clear


%number of days it took to learn the gist of the task during pretraining
wty_pretrain = [4,5,7,4,4,4,4,5,4,5]';
j20y_pretrain = [4,4,4,5,5,4,6,3,6,6,5]';
wto_pretrain = [2,4,4,4,5,2,3,4]';
j20o_pretrain = [5,4,4,4,4,4,5,5,2]';

%number of days it took to get 8/10 during dark training
wty_pretrain = [2,1,3,1,2,2,1,5,1,4]';
j20y_pretrain = [1,1,2,3,2,1,1,1,4,1,2]';
wto_pretrain = [1,2,2,1,2,1,2,1]';
j20o_pretrain = [2,1,1,3,3,1,1,1,1]';

%this is for number of days above 8/10 in dark trials
wty_pretrain = [5,5,5,4,5,5,5,4,3,4]';
j20y_pretrain = [4,5,4,3,2,5,4,4,3,5,5]';
wto_pretrain = [5,5,5,5,4,1,3,4]';
j20o_pretrain = [4,4,3,1,5,4,2,3,0]';

%this is for number of days above 8/10 in light trials
wty_pretrain = [5,5,5,5,5,5,5,5,5,5]';
j20y_pretrain = [5,5,5,5,5,5,5,5,3,5,5]';
wto_pretrain = [5,5,4,5,5,5,4,5]';
j20o_pretrain = [0,5,5,5,5,5,4,5,3]'; 

%% Fig.S18b-d bar plots
% bar plot 

wtymean = nanmean(wty_pretrain)
wtomean = nanmean(wto_pretrain)
j20ymean = nanmean(j20y_pretrain)
j20omean = nanmean(j20o_pretrain)

wtysem = nanstd(wty_pretrain)/sqrt(length(wty_pretrain) - sum(isnan(wty_pretrain)))
wtosem = nanstd(wto_pretrain)/sqrt(length(wto_pretrain) - sum(isnan(wto_pretrain)))
j20ysem = nanstd(j20y_pretrain)/sqrt(length(j20y_pretrain) - sum(isnan(j20y_pretrain)))
j20osem = nanstd(j20o_pretrain)/sqrt(length(j20o_pretrain) - sum(isnan(j20o_pretrain)))

meanvalues = [wtymean;  wtomean; j20ymean; j20omean]; 
E = [wtysem; wtosem; j20ysem; j20osem];

figure
hold on
bar(meanvalues, 'BarWidth',1)
% errorbar(E, meanvalues)
ylabel('Field size')
xlabel('Testing conditions')
set(gca,'FontName','Calibri','FontSize',14,'XTick',1:4,'XTickLabel',{'WTy','WTo','J20y','J20o'})
set(gcf, 'color', [1 1 1])
set(gca, 'color', [1 1 1])
grid off
box off
hold on 
% for i = 1:length(wty_pretrain)
%     scatter(1,(wty_pretrain(i,1)))
%     hold on
% end

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
scatter(linspace(.85,.85,size(wty_pretrain,1)), wty_pretrain, 'k', 'filled')
hold on
scatter(linspace(1.85,1.85,size(wto_pretrain,1)), wto_pretrain, 'r', 'filled')
hold on
scatter(linspace(2.85,2.85,size(j20y_pretrain,1)), j20y_pretrain, 'b', 'filled')
hold on
scatter(linspace(3.85,3.85,size(j20o_pretrain,1)), j20o_pretrain, 'g', 'filled')

%% 2-sided wilcoxin rank sum test
%bonferonni holm correction was applied manually 

ranksum(wty_pretrain,j20y_pretrain)
ranksum(wty_pretrain,wto_pretrain)
ranksum(j20y_pretrain,j20o_pretrain)
ranksum(wto_pretrain,j20o_pretrain)

%% Fig.S18c-d line plots

clear 

%across days training
wty_pretrain = [7,9,8,9,9;8,10,7,8,8;6,7,9,10,10;8,9,9,8,9;7,9,8,9,10;7,9,10,8,9;8,9,9,8,9;5,6,6,6,9;9,9,8,6,8;6,7,7,8,10];
j20y_pretrain = [8,7,8,9,9;9,7,9,9,9;6,9,10,8,8;3,8,8,9,10;7,9,8,10,10;9,8,9,8,9;8,10,9,7,10;9,8,6,9,8;7,6,6,9,7;8,9,8,10,8;7,8,6,8,9];
wto_pretrain = [9,8,10,9,10;7,8,9,10,7;7,8,8,9,10;9,8,9,10,9;7,9,9,10,8;8,8,8,7,10;6,10,8,8,10;6,10,10,10,9];
j20o_pretrain = [7,8,9,10,10;9,8,9,9,8;9,8,9,9,10;5,7,8,9,8;6,6,9,9,8;9,9,8,9,8;9,9,7,10,8;9,7,7,9,9;8,7,6,9,7];

%across dark days testing
wty_pretrain = [9,9,10,10,9;8,10,9,9,8;9,10,8,9,10;8,10,9,7,10;9,8,9,8,8;9,8,8,9,9;10,10,9,10,9;8,8,7,8,8;7,9,7,8,9;8,8,10,10,7];
j20y_pretrain = [9,10,10,8,7;8,8,9,9,8;10,10,10,7,8;8,8,9,7,7;8,7,7,8,6;8,8,9,8,8;10,9,10,7,10;9,8,9,8,6;9,7,6,10,9;8,10,10,9,9;8,9,8,8,8];
wto_pretrain = [9,9,9,8,10;9,10,9,9,10;8,9,8,9,9;10,10,9,10,8;10,9,9,7,9;7,4,8,6,7;6,9,7,9,10;7,10,9,10,10];
j20o_pretrain = [8,8,9,8,6;9,9,9,8,6;9,7,7,10,8;8,7,7,6,7;10,10,8,9,10;8,8,9,8,3;9,8,6,7,6;8,7,7,10,10;6,7,7,3,6];

%across light days testing 
wty_pretrain = [8,10,9,10,9;10,10,10,10,8;9,9,9,9,10;10,10,10,10,10;9,10,8,10,9;10,10,10,10,10;10,10,10,10,10;8,8,8,10,9;10,9,10,9,10;10,10,10,9,8];
j20y_pretrain = [10,10,10,10,9;10,10,10,10,10;10,10,9,9,10;10,9,10,10,9;9,9,8,8,8;9,10,10,9,9;9,10,10,9,9;9,9,9,10,9;9,9,7,7,10;10,10,9,10,9;10,9,10,9,9];
wto_pretrain = [10,9,10,10,10;10,10,10,10,10;10,10,10,7,10;10,10,10,10,10;10,10,10,10,10;8,10,8,9,9;9,8,7,10,9;9,10,10,9,10];
j20o_pretrain = [0,0,0,0,0;10,9,9,10,10;10,10,10,10,10;10,10,10,10,10;10,10,10,10,10;10,10,10,10,10;10,10,9,8,7;10,10,8,10,10;9,10,9,5,6]; %does NOT include the data from that 1 anxious mouse Z2 

wtymean = nanmean(wty_pretrain,1)
wtamean = nanmean(wto_pretrain,1)
j20ymean = nanmean(j20y_pretrain,1)
j20amean = nanmean(j20o_pretrain,1)

wtyerror = nanstd(wty_pretrain,1)/sqrt(length(wty_pretrain) - sum(isnan(wty_pretrain(:,1))) );
wtaerror = nanstd(wto_pretrain,1)/sqrt(length(wto_pretrain) - sum(isnan(wto_pretrain(:,1))) );
j20yerror = nanstd(j20y_pretrain,1)/sqrt(length(j20y_pretrain) - sum(isnan(j20y_pretrain(:,1))) );
j20aerror = nanstd(j20o_pretrain,1)/sqrt(length(j20o_pretrain) - sum(isnan(j20o_pretrain(:,1))) );


figure 
errorbar(wtymean,wtyerror,'r')
hold on 
errorbar(wtamean,wtaerror,'k')
hold on 
errorbar(j20ymean,j20yerror,'c')
hold on 
errorbar(j20amean,j20aerror,'b')
hold on 
xlim([0 6])
hold on 
ylim([0 10])





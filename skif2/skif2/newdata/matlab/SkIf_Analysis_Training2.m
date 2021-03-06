clear all;
close all;
warning off;

sids = [1:22 24:50 101:106 114:119];


types = {'Skill' 'Training'};

for i =[1:length(sids)]
    sud = sids(i);
    for j = [1:length(types)]
        x = load(sprintf('%d_%s_3.txt', sud, types{j}));
        
% Block Trial Symbol Pre_Cue Reliability Response RT Accuracy
  
        data{i,j} = x(:,[2 3 10 11 12 13 14 15]);
        
% Association_1 Association_2 Association_3 Association_4 Tr5aining_Condition Order_Condition

        cond{i,j} = x(1,[4:9]);
    end
end
cco = [0 0];
for i =[1:length(sids)]
    if(cond{i,1}(5) < 0)
        cc = 1;
    else
        cc = 2;
    end
    cco(cc) = cco(cc) + 1;
    sidx = cco(cc);
    
    allbks{cc}(sidx,:) = data{i,2}(:,1);
    allrts{cc}(sidx,:) = data{i,2}(:,7);
    allacs{cc}(sidx,:) = data{i,2}(:,8);
    allrbs{cc}(sidx,:) = data{i,2}(:,5);

    % reliable and unreliable indexes
    idxr = find(allrbs{cc}(sidx,:) == 1);
    idxu = find(allrbs{cc}(sidx,:) == 0);
    % correct and incorrect
    idxc = find(allacs{cc}(sidx,:) == 1);
    idxi = find(allacs{cc}(sidx,:) == 0);
    % correct and incorrect for reliable/unreliable
    idxrc = idxr(find(allacs{cc}(sidx,idxr) == 1));
    idxri = idxr(find(allacs{cc}(sidx,idxr) == 0));
    idxuc = idxu(find(allacs{cc}(sidx,idxu) == 1));
    idxui = idxu(find(allacs{cc}(sidx,idxu) == 0));
    
% KEY
% {condition -600|600}
% {reliability yes|no ; all|correct|incorrect}
% (block ; sid}
    for bk = [1:16]
        bkidx = idxr(find(allbks{cc}(sidx,idxr)==bk));
        rts{cc}{1,1}(bk, sidx) = mean(allrts{cc}(sidx, bkidx));
        bkidx = idxrc(find(allbks{cc}(sidx,idxrc)==bk));
        rts{cc}{1,2}(bk, sidx) = mean(allrts{cc}(sidx, bkidx));
        bkidx = idxri(find(allbks{cc}(sidx,idxri)==bk));
        rts{cc}{1,3}(bk, sidx) = mean(allrts{cc}(sidx, bkidx));
        bkidx = idxu(find(allbks{cc}(sidx,idxu)==bk));
        rts{cc}{2,1}(bk, sidx) = mean(allrts{cc}(sidx, bkidx));
        bkidx = idxuc(find(allbks{cc}(sidx,idxuc)==bk));
        rts{cc}{2,2}(bk, sidx) = mean(allrts{cc}(sidx, bkidx));
        bkidx = idxui(find(allbks{cc}(sidx,idxui)==bk));
        rts{cc}{2,3}(bk, sidx) = mean(allrts{cc}(sidx, bkidx));
        
        bkidx = idxr(find(allbks{cc}(sidx,idxr)==bk));
        acs{cc}{1,1}(bk, sidx) = mean(allacs{cc}(sidx, bkidx));
        bkidx = idxrc(find(allbks{cc}(sidx,idxrc)==bk));
        acs{cc}{1,2}(bk, sidx) = mean(allacs{cc}(sidx, bkidx));
        bkidx = idxri(find(allbks{cc}(sidx,idxri)==bk));
        acs{cc}{1,3}(bk, sidx) = mean(allacs{cc}(sidx, bkidx));
        bkidx = idxu(find(allbks{cc}(sidx,idxu)==bk));
        acs{cc}{2,1}(bk, sidx) = mean(allacs{cc}(sidx, bkidx));
        bkidx = idxuc(find(allbks{cc}(sidx,idxuc)==bk));
        acs{cc}{2,2}(bk, sidx) = mean(allacs{cc}(sidx, bkidx));
        bkidx = idxui(find(allbks{cc}(sidx,idxui)==bk));
        acs{cc}{2,3}(bk, sidx) = mean(allacs{cc}(sidx, bkidx));
    end
end

%%

for cc = [1:2]
    for rr = [1:2]
        for ac = [1:3]
            for bk = [1:16]
                RTmu{cc}{rr,ac}(bk) = nanmean(rts{cc}{rr,ac}(bk,:));
                RTse{cc}{rr,ac}(bk) = nanstd(rts{cc}{rr,ac}(bk,:))./sqrt(length(rts{cc}{rr,ac}(bk,:)));
                ACmu{cc}{rr,ac}(bk) = nanmean(acs{cc}{rr,ac}(bk,:));
                ACse{cc}{rr,ac}(bk) = nanstd(acs{cc}{rr,ac}(bk,:))./sqrt(length(acs{cc}{rr,ac}(bk,:)));
            end
        end
    end
end

%%
figure();
errorbar([1:16], RTmu{1}{1,2}, RTse{1}{1,2}, 'b-', 'LineWidth', 2);
hold on;
errorbar([1:16], RTmu{2}{1,2}, RTse{2}{1,2}, 'r-', 'LineWidth', 2);

ylim([300 800]);
xlim([0 17]);
xlabel('Training block number');
legend('-600 msec SOA', '+600 msec SOA');
ylabel('Mean correct RT (msec)');


%%
figure();
subplot(2,1,1);
errorbar([1:16], ACmu{1}{1,1}, ACse{1}{1,1}, 'b-', 'LineWidth', 2);
hold on;
errorbar([1:16], ACmu{2}{1,1}, ACse{2}{1,1}, 'r-', 'LineWidth', 2);

% ylim([.25 1]);
xlim([0 17]);
xlabel('Training block number');
legend('-600 msec SOA', '+600 msec SOA');
ylabel('Proportion correct');

%%
%%
subplot(2,1,2);
errorbar([1:16], RTmu{1}{2,2}-RTmu{1}{1,2}, mean([RTse{1}{1,2}; RTse{1}{2,2}], 1), 'b-', 'LineWidth', 2);
hold on;
errorbar([1:16], RTmu{2}{2,2}-RTmu{2}{1,2}, mean([RTse{2}{1,2}; RTse{2}{2,2}], 1), 'r-', 'LineWidth', 2);
plot([0 17], [0 0], 'k-');

% ylim([350 750]);
xlim([0 17]);
xlabel('Training block number');
legend('-600 msec SOA', '+600 msec SOA');
ylabel('Invalid-valid correct RT difference (msec)');


%%
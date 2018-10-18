clear all;
% close all;
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
badsuds = []
allrts{1,1} = [];
allrts{1,2} = [];
allrts{2,1} = [];
allrts{2,2} = [];
cco = [0 0];
for i =[1:length(sids)]
    if(cond{i,1}(5) < 0)
        cc = 1;
    else
        cc = 2;
    end
    cco(cc) = cco(cc) + 1;
    idxc = find(data{i,1}(:,5) == 1);
    idxi = find(data{i,1}(:,5) == 0);
%     allrts{cc}(end + 1: end + length(data{i,1}(:,7))) = data{i,1}(:,7);
    allrts{cc,1}(end + 1: end + length(data{i,1}(idxc,7))) = data{i,1}(idxc,7);
    allrts{cc,2}(end + 1: end + length(data{i,1}(idxi,7))) = data{i,1}(idxi,7);
    Ccomp{cc,1}(cco(cc),:) = mean(data{i,1}((idxc),8));
    Ccomp{cc,2}(cco(cc),:) = mean(data{i,1}((idxi),8));
%     mu = mean(log(data{i,1}(:,7)+600));
%     stdev = std(log(data{i,1}(:,7)+600));
%     zsc = ((log(data{i,1}(:,7)+600) - mu ) ./ stdev);
%     okitems = find(abs(zsc) < 2.5);
    okitems = find(data{i,1}(:,8) == 1);
    idxc = find(data{i,1}(okitems,5) == 1);
    idxi = find(data{i,1}(okitems,5) == 0);
    t = mean((data{i,1}(okitems(idxc),7)))
    rtcomp{cc,1}(cco(cc),:) = mean((data{i,1}(okitems(idxc),7)));
    if(t < 200)
        badsuds(end+1) = sids(i);
    end
%     if((cco(cc) == 24) || (cco(cc) == 25) || (cco(cc) == 34) || (cco(cc) == 35))
%         badsuds(end+1) = i;
%     end
        
    rtcomp{cc,2}(cco(cc),:) = mean((data{i,1}(okitems(idxi),7)));
    rtdiff{cc}(cco(cc),:) = mean((data{i,1}(okitems(idxi),7))) - mean((data{i,1}(okitems(idxc),7)));
end
figure();
subplot(2,1,1)
errorbar([-600 600], [mean(Ccomp{1, 1}, 1) mean(Ccomp{2, 1}, 1)], [std(Ccomp{1, 1}, 0, 1) std(Ccomp{2, 1}, 0, 1)]./sqrt(cco), 'b-', 'LineWidth', 2);
hold on;
errorbar([-600 600], [mean(Ccomp{1, 2}, 1) mean(Ccomp{2, 2}, 1)], [std(Ccomp{1, 2}, 0, 1) std(Ccomp{2, 2}, 0, 1)]./sqrt(cco), 'r-', 'LineWidth', 2);
legend('Reliable', 'Unreliable');
xlabel('SOA during training');
ylabel('Perc. Correct');

subplot(2,1,2)
errorbar([-600 600], [mean(rtcomp{1, 1}, 1) mean(rtcomp{2, 1}, 1)], [std(rtcomp{1, 1}, 0, 1) std(rtcomp{2, 1}, 0, 1)]./sqrt(cco), 'b-', 'LineWidth', 2);
hold on;
errorbar([-600 600], [mean(rtcomp{1, 2}, 1) mean(rtcomp{2, 2}, 1)], [std(rtcomp{1, 2}, 0, 1) std(rtcomp{2, 2}, 0, 1)]./sqrt(cco), 'r-', 'LineWidth', 2);
legend('Reliable', 'Unreliable');
xlabel('SOA during training');
ylabel('Response Time');
%%

figure();
Acc = [mean(Ccomp{1, 1}, 1) mean(Ccomp{2, 1}, 1); mean(Ccomp{1, 2}, 1) mean(Ccomp{2, 2}, 1)]';
AccE = [[std(Ccomp{1, 1}, 0, 1) std(Ccomp{2, 1}, 0, 1)]./sqrt(cco); [std(Ccomp{1, 2}, 0, 1) std(Ccomp{2, 2}, 0, 1)]./sqrt(cco)]';

barweb(Acc, AccE);


figure();
RTs = [mean(rtcomp{1, 1}, 1) mean(rtcomp{2, 1}, 1); mean(rtcomp{1, 2}, 1) mean(rtcomp{2, 2}, 1)]';
RTsE = [ [std(rtcomp{1, 1}, 0, 1) std(rtcomp{2, 1}, 0, 1)]./sqrt(cco); [std(rtcomp{1, 2}, 0, 1) std(rtcomp{2, 2}, 0, 1)]./sqrt(cco)]';

barweb(RTs, RTsE);

%%
colors = {'b-', 'r-'; 'c-', 'm-'};
figure();
for i = [1:2]
    for j = [1:2]
        [n x] = hist(log(allrts{i,j}+600), 300);
        plot(x, n./sum(n), colors{i,j});
        hold on;
    end
end
legend('cc1r1', 'cc1r2', 'cc2r1', 'cc2r2');

% interaction

diff = ([mean(Ccomp{1, 2}, 1) mean(Ccomp{2, 2}, 1)] - [mean(Ccomp{1, 1}, 1) mean(Ccomp{2, 1}, 1)]);
se1 = [std(Ccomp{1, 1}, 0, 1) std(Ccomp{2, 1}, 0, 1)]./sqrt(cco);
se2 = [std(Ccomp{1, 2}, 0, 1) std(Ccomp{2, 2}, 0, 1)]./sqrt(cco);

Tval = diff ./ mean([se1; se2], 1)
p(1) = pdf('T', Tval(1), cco(1)-1);
p(2) = pdf('T', Tval(2), cco(2)-1)

mui = [mean(rtcomp{1, 2}, 1) mean(rtcomp{2, 2}, 1)];
muc = [mean(rtcomp{1, 1}, 1) mean(rtcomp{2, 1}, 1)];
diff = ([mean(rtcomp{1, 2}, 1) mean(rtcomp{2, 2}, 1)] - [mean(rtcomp{1, 1}, 1) mean(rtcomp{2, 1}, 1)]);
se1 = [std(rtcomp{1, 1}, 0, 1) std(rtcomp{2, 1}, 0, 1)]./sqrt(cco);
se2 = [std(rtcomp{1, 2}, 0, 1) std(rtcomp{2, 2}, 0, 1)]./sqrt(cco);

Tval = diff ./ mean([se1; se2], 1)
p(1) = pdf('T', Tval(1), cco(1)-1);
p(2) = pdf('T', Tval(2), cco(2)-1)


for cc = [1:2]
    for i = [1:cco(cc)]
        fprintf('\n%d\t%d\t%0.5g\t%0.5g\t%0.5g\t%0.5g', cc, i, Ccomp{cc,1}(i), Ccomp{cc,2}(i), rtcomp{cc,1}(i), rtcomp{cc, 2}(i));
    end
end

disp('RT -600');
[h p ci] = ttest(rtcomp{1,1}, rtcomp{1,2})
disp('RT +600');
[h p ci] = ttest(rtcomp{2,1}, rtcomp{2,2})
disp('RT diff -600');
[h p ci] = ttest(rtdiff{1}, 0)
disp('RT diff +600');
[h p ci] = ttest(rtdiff{2}, 0)
disp('Acc -600');
[h p ci] = ttest(Ccomp{1,1}, Ccomp{1,2})
disp('Acc +600');
[h p ci] = ttest(Ccomp{2,1}, Ccomp{2,2})
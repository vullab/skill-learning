clear all;
close all;
warning off;
sids = [1:90];

for i =[1:length(sids)]
    sud = sids(i);
    x = load(sprintf('p2_%d.txt', sud));

% block trial cor rt
    data{i} = x(:,[2 3 8 9]);

% cond

    cond{i} = x(1,[4]);
end

cco = [0 0 0 0];

for sid = [1:length(sids)]
    cc = cond{sid};
    cco(cc) = cco(cc) + 1;
    
    correct = find(data{sid}(:,3) == 1);
    for block = [1:32]
        bkidx = find(data{sid}(correct,1)==block);
        rtmean{cc}(cco(cc),block) = mean(data{sid}(correct(bkidx), 4));
    end
end

for cc = [1:4]
    mubk{cc} = nanmean(rtmean{cc});
    sebk{cc} = nanstd(rtmean{cc})./sqrt(cco(cc));
end

colors = {'ro-', 'bx-', 'gs-', 'cv-'};

figure();
for cc = [1:4]
    errorbar([1:32]+(rand(1,32)-.5)./4, mubk{cc}, sebk{cc}, colors{cc});
    hold on;
end
legend('Hard (random letters)', 'Medium (p=0.85 repeat)', 'One letter/block', 'Pre-target warning');
ylabel('mean correct RT');
xlabel('block number');

%%

figure();
% for cc = [1:4]
    rx = (rand(1,16)-.5)./3
    errorbar([17:32]+rx, mubk{1}(1:16), sebk{1}(1:16), 'r--', 'LineWidth', 2);
%     hold on;
%     plot([17:32]+rx, mubk{1}(1:16), 'r--', 'LineWidth', 3);
    hold on;
    rx = (rand(1,16)-.5)./3
    errorbar([17:32]+rx, mubk{1}(17:32), sebk{1}(17:32), 'r-', 'LineWidth', 2);
%     plot([17:32]+rx, mubk{1}(17:32), 'r-', 'LineWidth', 3);
%     hold on;
    rx = (rand(1,16)-.5)./3
    errorbar([17:32]+rx, mubk{2}(17:32), sebk{2}(17:32), 'b-', 'LineWidth', 3);
%     plot([17:32]+rx, mubk{2}(17:32), 'b-', 'LineWidth', 3);
%     hold on;
    rx = (rand(1,16)-.5)./3
    errorbar([17:32]+rx, mubk{3}(17:32), sebk{3}(17:32), 'g-', 'LineWidth', 3);
%     plot([17:32]+rx, mubk{3}(17:32), 'g-', 'LineWidth', 3);
%     hold on;
    rx = (rand(1,16)-.5)./3
    errorbar([17:32]+rx, mubk{4}(17:32), sebk{4}(17:32), 'c-', 'LineWidth', 3);
%     plot([17:32]+rx, mubk{4}(17:32), 'c-', 'LineWidth', 3);
%     hold on;
% end
legend('Hard (random letters) Blk 1-16', 'Hard (random letters) Blk 17-32', 'Medium (p=0.85 repeat) Blk 17-32', 'One letter/block Blk 17-32', 'Pre-target warning Blk 17-32');
ylabel('mean correct RT');
xlabel('block number');

%%

% print for excel
fprintf('\nC1 mean\tC2 mean\tC3 mean\tC4 mean\tC1 sder\tC2 sder\tC3 sder\tC4 sder');
for bk = [1:32];
    fprintf('\n');
    for cc = [1:4];
        fprintf('%4.2f\t', mubk{cc}(bk));
    end
    for cc = [1:4];
        fprintf('%4.2f\t', sebk{cc}(bk));
    end
end
%%
% statistics

% for comp = [1]
%     fprintf('\n');
%     for bk = [17:32]
%         fprintf('\n%2.3f\t%2.3f', mean(rtmean{comp}(:,bk-16)), std(rtmean{comp}(:,bk-16)));
%     end
% end

for comp = [2:4]
    fprintf('\n');
    fprintf('%d\n', comp);
    for bk = [17:32]
%         fprintf('\n\n %3.0f %3.0f; %3.0f', mean(rtmean{1}(:,bk-16)), mean(rtmean{comp}(:,bk)), (mean(rtmean{1}(:,bk-16)) - mean(rtmean{comp}(:,bk))));
        mu1 = mean(rtmean{1}(:,bk));
        mu2 = mean(rtmean{comp}(:,bk));
        sd1 = std(rtmean{1}(:,bk));
        sd2 = std(rtmean{comp}(:,bk));
        n1 = length(rtmean{1}(:,bk));
        n2 = length(rtmean{comp}(:,bk));
        sdd = sqrt( ((n1-1)*sd1^2 + (n2-1)*sd2^2)/(n1+n2+2) * (1/n1 + 1/n2) ) ;
        t = (mu1-mu2)/sdd;
        fprintf('\t%1.2f', t)
        if(cdf('T', t, (n1+n2-2)) < .05)
            fprintf('*');
        end
        
% %         y = mean([std(rtmean{comp}(:,bk))/sqrt(length(rtmean{comp}(:,bk))) std(rtmean{1}(:,bk-16))/sqrt(length(rtmean{1}(:,bk-16)))])
% %         [h p ci stats] = ttest2(rtmean{1}(:,bk-16), rtmean{comp}(:,bk));
% %         fprintf('\t%2.3f', stats.tstat);
% %         if(p<.05)
% %             fprintf('*');
% %         end
    end
end
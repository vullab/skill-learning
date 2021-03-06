clear all;
close all;
warning off;
sids = [24 25 27 32 34 35 36 37 39:43 45 51 52 54 56 57 59 60 62 63 66 68 69 71:74 77 79 80 82 83 85 86 108 109 111:114 116 117];

types = {'Skill' 'Training' 'Inference'};

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
    
    rtcomp{cc}(cco(cc),:) = mean(data{i,3}(:,7));
    Ccomp{cc}(cco(cc),:) = mean(data{i,3}(:,8));
end
figure();
subplot(2,1,1)
errorbar([-400 400], [mean(Ccomp{1}, 1) mean(Ccomp{2}, 1)], [std(Ccomp{1}, 0, 1) std(Ccomp{2}, 0, 1)]./sqrt(cco - 1), 'b-', 'LineWidth', 2);
xlabel('soa');
ylabel('Perc. correct (inference test)');
ylim([.25 1]);
title('Performance on Inference Test');

subplot(2,1,2)
errorbar([-400 400], [mean(rtcomp{1}, 1) mean(rtcomp{2}, 1)], [std(rtcomp{1}, 0, 1) std(rtcomp{2}, 0, 1)]./sqrt(cco - 1), 'b-', 'LineWidth', 2);
xlabel('soa');
ylabel('RT (inference test)');


Tval(1) = (mean(Ccomp{1}) - .25) ./ (std(Ccomp{1}, 0, 1)./sqrt(cco(1)-1));
Tval(2) = (mean(Ccomp{2}) - .25) ./ (std(Ccomp{2}, 0, 1)./sqrt(cco(2)-1));
Tval(3) = (mean(Ccomp{1}) - mean(Ccomp{2})) ./ (mean([std(Ccomp{1}, 0, 1) std(Ccomp{2}, 0, 1)])./sqrt(mean(cco)-1));

p(1) = pdf('T', Tval(1), cco(1)-1);
p(2) = pdf('T', Tval(2), cco(2)-1);
p(3) = pdf('T', Tval(3), sum(cco)-2);
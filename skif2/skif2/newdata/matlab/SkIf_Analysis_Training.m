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
    
    rtcomp{cc}(cco(cc),:) = data{i,2}(:,7);
    Ccomp{cc}(cco(cc),:) = data{i,2}(:,8);
    
%     training effect
fprintf('\n%d\t', i);
    idxr = find(data{i, 2}(:, 5) == 1);
fprintf('nr: %d\t', length(idxr));
    idxrc = find(data{i, 2}(idxr, 8) == 1);
fprintf('nrc: %d\t', length(idxrc));
    idxri = find(data{i, 2}(idxr, 8) == 0);
fprintf('nri: %d\t', length(idxri));
    
    idxu = find(data{i, 2}(:, 5) ~= 1);
fprintf('nu: %d\t', length(idxu));
    idxuc = find(data{i, 2}(idxu, 8) == 1);
fprintf('nuc: %d\t', length(idxuc));
    idxui = find(data{i, 2}(idxu, 8) == 0);
fprintf('nui: %d\t', length(idxui));
    
    dat{1,1} = data{i,2}(idxr,:);
    dat{1,2} = data{i,2}(idxr(idxrc),:);
%     size(idxrc)
    dat{1,3} = data{i,2}(idxr(idxri),:);
    dat{2,1} = data{i,2}(idxu,:);
    dat{2,2} = data{i,2}(idxu(idxuc),:);
%     size(idxuc)
    dat{2,3} = data{i,2}(idxu(idxui),:);
    for b = [1:16];
        for rc = [1:2]
            for aci = [1:3]
                bb = find(dat{rc,aci}(:,1) == b);
                Train_rt{cc}{rc, aci}(cco(cc),b) = mean(dat{rc,aci}(bb,7));
                Train_c{cc}{rc, aci}(cco(cc),b) = mean(dat{rc,aci}(bb,8));
            end
        end
    end
    
%     sb1 = find(dat{1,1}(:,1) > 8);
%     sb2 = find(dat{2,1}(:,1) > 8);
    
    z1{cc}(cco(cc)) = mean(dat{1,1}(:,7));
    z2{cc}(cco(cc)) = mean(dat{2,1}(:,7));
    diffRT{cc}(cco(cc)) = mean(dat{1,1}(:,7)) - mean(dat{2,1}(:,7));
    
    
end

for cc = [1:2]
    for b = [1:16]
        for r = [1 2]
            muRT{cc,r}(b) = mean(Train_rt{cc}{r,2}(:,b));
            seRT{cc,r}(b) = std(Train_rt{cc}{r,2}(:,b))./sqrt(length(sids));
            muC{cc,r}(b) = mean(Train_c{cc}{r,1}(:,b));
            seC{cc,r}(b) = std(Train_c{cc}{r,1}(:,b))./sqrt(length(sids));
        end
    end
end
figure();
subplot(2,1,1)
errorbar([1:16], muRT{1,1}, seRT{1,1}, 'b-', 'LineWidth', 2);
hold on;
errorbar([1:16], muRT{2,1}, seRT{2,1}, 'r-', 'LineWidth', 2);
ylim([350 800]);
% errorbar([1:16], muRT{1,2}, seRT{1,2}, 'g:');
% errorbar([1:16], muRT{2,2}, seRT{2,2}, 'm:');
xlabel('Training block number');
ylabel('RT')
legend('-600 msec SOA', '+600 msec SOA');
title('Pre-cueing during training (RT and accuracy)');


subplot(2,1,2);
errorbar([1:16], muC{1,1}, seC{1,1}, 'b-', 'LineWidth', 2);
hold on;
errorbar([1:16], muC{2,1}, seC{2,1}, 'r-', 'LineWidth', 2);
% errorbar([1:16], muC{1,2}, seC{1,2}, 'g:', 'LineWidth', 2);
% errorbar([1:16], muC{2,2}, seC{2,2}, 'm:', 'LineWidth', 2);
xlabel('Training block number');
ylabel('Perc. correct')
legend('-600 msec SOA', '+600 msec SOA');
% ylim([.25 1]);

% figure();
% loglog([1:size(rtcomp{2}, 2)], mean(rtcomp{1}, 1), 'b', 'LineWidth', 2);
% hold on;
% loglog([1:size(rtcomp{2}, 2)], mean(rtcomp{2}, 1), 'r', 'LineWidth', 2);
df = (length(Train_rt{1}{1,1}(:,b)) + length(Train_rt{2}{1,1}(:,b)))-2;
Tval = ((muRT{1,1} - muRT{2,1}) ./ ...
     ((seRT{1,1}.*length(Train_rt{1}{1,1}(:,b)) + seRT{2,1}.*length(Train_rt{2}{1,1}(:,b)))./ ...
       (length(Train_rt{1}{1,1}(:,b)) + length(Train_rt{2}{1,1}(:,b)))));
p = pdf('T', Tval, df).*2;


Cdf = (length(Train_rt{1}{1,1}(:,b)) + length(Train_rt{2}{1,1}(:,b)))-2;
CTval = ((muC{2,1} - muC{1,1}) ./ ...
     ((seC{1,1}.*length(Train_rt{1}{1,1}(:,b)) + seC{2,1}.*length(Train_rt{2}{1,1}(:,b)))./ ...
       (length(Train_rt{1}{1,1}(:,b)) + length(Train_rt{2}{1,1}(:,b)))));
Cp = pdf('T', CTval, Cdf).*2;

% for cc = [1:2]
    fprintf('\n');
    for i = [1:16]
        fprintf('\t%0.5g', Cp(i));
    end
% end

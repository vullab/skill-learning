clear all;
close all;
warning off;
% sids = [24 25 27 32 34 35 36 37 39:43 45 51 52 54 56 57 59 60 62 63 66 68 69 71:74 77 79 80 82 83 85 86 108 109 111:114 116 117];
sids = [1:60];
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
    dat{1,2} = data{i,2}(idxrc,:);
    dat{1,3} = data{i,2}(idxri,:);
    dat{2,1} = data{i,2}(idxu,:);
    dat{2,2} = data{i,2}(idxuc,:);
    dat{2,3} = data{i,2}(idxui,:);
    for b = [1:16];
        for rc = [1:2]
            for aci = [1:3]
                bb = find(dat{rc,aci}(:,1) == b);
                Train_rt{cc}{rc, aci}(cco(cc),b) = mean(dat{rc,aci}(bb,7));
                Train_c{cc}{rc, aci}(cco(cc),b) = mean(dat{rc,aci}(bb,8));
            end
        end
    end
    
    
end

for cc = [1:2]
    for b = [1:16]
        for r = [1 2]
            muRT{cc,r}(b) = mean(Train_rt{cc}{r,1}(:,b));
            seRT{cc,r}(b) = std(Train_rt{cc}{r,1}(:,b))./sqrt(length(sids));
            muC{cc,r}(b) = mean(Train_c{cc}{r,1}(:,b));
            seC{cc,r}(b) = std(Train_c{cc}{r,1}(:,b))./sqrt(length(sids));
        end
    end
end
figure();
subplot(2,1,1)
errorbar([1:16], muRT{1,1}, seRT{1,1}, 'b-');
hold on;
errorbar([1:16], muRT{2,1}, seRT{2,1}, 'r-');
errorbar([1:16], muRT{1,2}, seRT{1,2}, 'g:');
errorbar([1:16], muRT{2,2}, seRT{2,2}, 'm:');
subplot(2,1,2);
errorbar([1:16], muC{1,1}, seC{1,1}, 'b-');
hold on;
errorbar([1:16], muC{2,1}, seC{2,1}, 'r-');
errorbar([1:16], muC{1,2}, seC{1,2}, 'g:');
errorbar([1:16], muC{2,2}, seC{2,2}, 'm:');
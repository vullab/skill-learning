sids = [24 25 27 32 34 35 36 37 39:43 45 51 52 54 56 57 59 60 62 63 66 68 69 71:74 77 79 80 82 83 85 86 108 109 111:114 116 117];

types = {'Skill' 'Training' 'Inference'};

for i =[1:length(sids)]
    sud = sids(i);
    for j = [1:length(types)]
        fr = fopen(sprintf('%d_%s.xls', sud, types{j}), 'r');
        fw = fopen(sprintf('%d_%s_3.txt', sud, types{j}), 'w');
        
        line = fgetl(fr);
        line = fgetl(fr);
        line = fgetl(fr);
        
        while(ischar(line))
            line = regexprep(line, '  ', ' ');
            line = regexprep(line, '  ', ' ');
            line = regexprep(line, '  ', ' ');
            
            line = regexprep(line, '  ', '\t');
            fprintf(fw, '%s\n', line);
            line = fgetl(fr);
        end
        fclose(fr);
        fclose(fw);
    end
end
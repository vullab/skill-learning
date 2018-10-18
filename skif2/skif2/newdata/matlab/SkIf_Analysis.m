sids = [101:119];

types = {'Skill' 'Training'};

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
sids = [1:90];


for i =[1:length(sids)]
    sud = sids(i);
        fr = fopen(sprintf('%d.txt', sud), 'r');
        fw = fopen(sprintf('p2_%d.txt', sud), 'w');
        
        line = fgetl(fr);
        line = fgetl(fr);
        line = fgetl(fr);
        
        while(ischar(line))
            line = regexprep(line, '  ', ' ');
            line = regexprep(line, '  ', ' ');
            line = regexprep(line, '  ', ' ');
            
            line = regexprep(line, '  ', '\t');
            line = regexprep(line, 'C', '1');
            line = regexprep(line, 'I', '0');
            line = regexprep(line, '[^0-9 \t\n]', '999');
            fprintf(fw, '%s\n', line);
            line = fgetl(fr);
        end
        fclose(fr);
        fclose(fw);
end
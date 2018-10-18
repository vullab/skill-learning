library(tidyverse)

rm(list=ls())
filepath = '../skill-learn-5/data/'
files <- list.files(filepath)

columnnames <- c("RT", "SRmap_0", "SRmap_1", "SRmap_2", "SRmap_3", "SRmap_4", "SRmap_5", "condition", "correct", "correct_response", "curstim", "ms.precue", "ms.prestimblank", "ntrials", "response", "subject", "trial",  "type")
dat = data.frame(row.names = columnnames)

for(f in files){
  q = read_csv(paste(filepath, f, sep=""))
  dat <- rbind(dat, q)
}
dat <- dat[!dat$subject=="subject",]

dat %>% 
  mutate(block = floor((trial-1)/10),
         RT = log10(RT)) %>%
  group_by(subject, block, condition) %>%
  summarize(ac = mean(correct),
            rt = mean(RT[correct==1]),
            n = n()) %>%
  group_by(block, condition) %>%
  summarize(rt.mean = mean(rt),
            rt.sem = sd(rt)/sqrt(n()),
            ac.mean = mean(ac),
            ac.sem = sd(ac)/sqrt(n())) %>%
  ggplot(aes(x=block, y=rt.mean, ymax=rt.mean+rt.sem, ymin=rt.mean-rt.sem, color=condition))+
  geom_pointrange()+
  geom_line()





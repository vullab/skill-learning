library(tidyverse)

filepath = '../traintype/data/'
cleanfile = 'data_cleaned/traintype.csv'
files = list.files(filepath, pattern = '^[0-9]+.txt')

dat = tibble()
for(file in files){
  dat <- read_tsv(paste0(filepath, file), skip = 1, col_names = T) %>%
    mutate(filename = file) %>%
    bind_rows(dat)
}

n = names(dat)
n[1] = 'sid'
n[11] = 'blank'
names(dat) <- n

files = list.files(filepath, pattern = '^p_[0-9]+.txt')
for(file in files){
  dat <- read_tsv(paste0(filepath, file), col_names = n[1:11]) %>%
    mutate(filename = file) %>%
    bind_rows(dat)
}

dat = dat %>% select(-c(filename, blank)) %>%
  mutate(Condition = case_when(
    Condition == 1 ~ 'Random',
    Condition == 2 ~ 'p(rep) = 0.85',
    Condition == 3 ~ 'p(rep) = 1.00 (block)',
    Condition == 4 ~ 'Precue'
  ))

write_csv(dat, cleanfile)

dat %>% group_by(sid, Block, Condition) %>%
  summarize(rt = mean(RT[Accuracy == 'C'])) %>%
  group_by(Block, Condition) %>%
  summarize(m = mean(rt),
            sem = sd(rt)/sqrt(n())) %>%
  ggplot(aes(x=Block, y=m, ymax=m+sem, ymin=m-sem, color=as.character(Condition)))+
  geom_pointrange()+
  geom_line()

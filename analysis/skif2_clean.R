library(tidyverse)

filepath = '../skif2/skif2/newdata/'
cleanfile = 'data_cleaned/skif2.csv'
files = list.files(filepath, pattern = '*.txt')

dat = tibble()
for(file in files){
  dat <- read_tsv(paste0(filepath, file), col_names = FALSE) %>%
    mutate(filename = file) %>%
    bind_rows(dat)
}

names(dat) <- c('sid',  
                'block', 
                'trial',
                'associaiton_1',
                'association_2',
                'association_3',
                'association_4',
                'training_condition',
                'order_condition',
                'symbol',
                'cue',
                'cue_correct',
                'response',
                'rt',
                'correct',
                'blank',
                'filename')
dat <- dat %>% separate(filename, c('file_sid', 'phase', 'extranum', 'file_ext')) %>%
  mutate(sid = file_sid)

unique(dat$blank)
unique(dat$extranum)
unique(dat$file_ext)

dat <- dat %>% 
  select(-c(blank, file_sid, file_ext, extranum)) %>% 
  glimpse()

write_csv(dat, cleanfile)

library(tidyverse)

# this is E3 in the paper!

cleanfile = 'data_cleaned/skif1.csv'

dat <- read_csv(cleanfile)

# Fig 3.a
dat %>% 
  filter(phase == 'Training') %>%
  mutate(condition = as.character(training_condition)) %>%
  group_by(correct, sid, block, condition) %>%
  summarise(m = mean(rt), s = sd(rt), n=n()) %>%
  filter(correct == 1) %>%
  group_by(condition, block) %>%
  summarize(rt.mean = mean(m), rt.sem = sd(m)/sqrt(n())) %>%
  ggplot(aes(x=block, y=rt.mean, color=condition))+
  geom_pointrange(aes(ymin = rt.mean-rt.sem, ymax=rt.mean+rt.sem))+
  geom_line()

# Fig 3.b
dat %>% 
  filter(phase == 'Training') %>%
  mutate(condition = as.character(training_condition)) %>%
  group_by(sid, block, condition) %>%
  summarise(m = mean(correct)) %>%
  group_by(condition, block) %>%
  summarize(mean = mean(m), sem = sd(m)/sqrt(n())) %>%
  ggplot(aes(x=block, y=mean, color=condition))+
  geom_pointrange(aes(ymin = mean-sem, ymax=mean+sem))+
  geom_line()


# Fig 3.c # fix weirdness with error bars.
dat %>% 
  filter(phase == 'Training') %>%
  filter(correct == 1) %>%
  mutate(condition = as.character(training_condition)) %>%
  group_by(sid, block, condition, cue_correct) %>% 
  summarise(m = mean(rt)) %>%
  group_by(condition, block, cue_correct) %>%
  summarise(m = mean(m), se = sd(m)/sqrt(n())) %>%
  group_by(condition, block) %>%
  summarize(delta = m[cue_correct==0] - m[cue_correct==1],
            sem = sqrt(sum(se^2))) %>%
  ggplot(aes(x=block, y=delta, color=condition))+
  geom_pointrange(aes(ymin = delta-sem, ymax=delta+sem))+
  geom_line()

# Fig 3.d,e
dat %>% 
  filter(phase == 'Skill') %>%
  mutate(condition = as.character(training_condition),
         cue_correct= case_when(
           cue_correct == 1 ~ 'Consistent',
           cue_correct == 0 ~ 'Inconsistent'
         )) %>%
  group_by(sid, condition, cue_correct) %>%
  summarize(rt = mean(rt[correct==1]),
            acc = mean(correct)) %>%
  gather(key=measure, value=val, c(rt, acc)) %>% 
  group_by(condition, cue_correct, measure) %>%
  summarize(m = mean(val),
            sem = sd(val)/sqrt(n())) %>% 
  ggplot(aes(x=condition, color=cue_correct, y=m, ymax=m+sem, ymin=m-sem))+
  facet_wrap(~measure, scales = 'free_y')+
  geom_pointrange(position=position_dodge())


# new figure.
# validity effect during testing block
dat %>% 
  filter(phase == 'Skill') %>%
  mutate(condition = as.character(training_condition),
         cue_correct= case_when(
           cue_correct == 1 ~ 'Consistent',
           cue_correct == 0 ~ 'Inconsistent'
         )) %>%
  group_by(sid, condition, cue_correct, block) %>%
  summarize(rt = mean(rt),
            acc = mean(correct)) %>%
  gather(key=measure, value=val, c(rt, acc)) %>% 
  group_by(sid, block, condition, measure) %>%
  summarize(delta = val[cue_correct == 'Consistent'] - val[cue_correct=='Inconsistent']) %>%
  group_by(block, condition, measure) %>% glimpse() %>%
  summarize(m = mean(delta),
            sem = sd(delta)/sqrt(n())) %>% 
  ggplot(aes(x=block, color=condition, y=m, ymax=m+sem, ymin=m-sem))+
  facet_wrap(~measure, scales = 'free_y')+
  geom_pointrange()+
  geom_line()

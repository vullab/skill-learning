library(tidyverse)
rm(list=ls())
filepath = '../skill-learn-3/data/'
files <- list.files(filepath)

s = 1
columnnames <- c("RT", "correct_response", "ms.prestimblank", "curstim", "correct", "SRmap_1", "SRmap_0", "SRmap_3", "SRmap_2", "SRmap_5", "SRmap_4", "ms.precue", "ntrials", "type", "response", "condition", "subject", "trial")
dat = data.frame(row.names = columnnames)

for(f in files){
  q = read_csv(paste(filepath, f, sep=""))
  q$subject = s
  n = nrow(q)
  q$trial = 1:n
  names(q) <- columnnames
  dat <- rbind(dat, q)
  s = s+1
}

dat = dat %>% 
  mutate(block = floor((trial-1)/10))

dat %>% 
  mutate(RT = log10(RT)) %>%
  group_by(subject, block, type, condition) %>%
  summarize(ac = mean(correct),
            rt = mean(RT[correct==1]),
            n = n()) %>%
  group_by(block, condition, type) %>%
  summarize(rt.mean = mean(rt),
            rt.sem = sd(rt)/sqrt(n()),
            ac.mean = mean(ac),
            ac.sem = sd(ac)/sqrt(n())) %>%
  ggplot(aes(x=block, y=rt.mean, ymax=rt.mean+rt.sem, ymin=rt.mean-rt.sem, color=condition))+
  facet_wrap(vars(type), nrow=2, scales = 'free_x')+
  geom_pointrange()+
  geom_line()

dat %>%
  mutate(block = floor((trial-1)/10)) %>%
  mutate(difficulty = )
  group_by(subject, block, type, condition) %>%
  
  


conditions <- unique(dat$condition)
subjects <- lapply(conditions, function(c){unique(dat$subject[dat$condition==conditions[c]])})
trialmod = 10

RTdat <- list()
ACdat <- list()
for(c in conditions)
{
  cnum = which(conditions == c)
  RTdat[[cnum]] <- matrix(data=NA, nrow=length(subjects[[cnum]]), ncol=50)
  ACdat[[cnum]] <- matrix(data=NA, nrow=length(subjects[[cnum]]), ncol=50)
  for(s in subjects[[cnum]])
  {
    snum = which(subjects[[cnum]] == s)
    for(block in 1:50)
    {
      filter = dat$condition==c & dat$subject==s & (dat$trial <= block*10) & (dat$trial > (block-1)*10)
      myt = dat[filter,]
      ACdat[[cnum]][snum,block] = mean(myt$correct, na.rm=T)
      RTdat[[cnum]][snum,block] = mean(myt$RT[myt$correct==1], na.rm=T)
    }
  }
}

colors = list(rgb(0, 0.5, 0), rgb(0.5, 0, 0), rgb(0.5, 0, 0.5), rgb(0, 0.5, 0.5), rgb(0,0,0))

plot( 1-colMeans(as.array(ACdat[[1]]), na.rm=T), ylim=c(0,0.25), type='l', col=colors[[1]])
lines(1-colMeans(as.array(ACdat[[2]]), na.rm=T), col=colors[[2]])
lines(1-colMeans(as.array(ACdat[[3]]), na.rm=T), col=colors[[3]])
lines(1-colMeans(as.array(ACdat[[4]]), na.rm=T), col=colors[[4]])
lines(1-colMeans(as.array(ACdat[[5]]), na.rm=T), col=colors[[5]])


fancyplot <- function(D, color){
  n = nrow(D)
  k = ncol(D)
  se = apply(log10(D),2, function(q){sd(q, na.rm=T)})/sqrt(n)
  mu = apply(log10(D), 2, function(q){mean(q, na.rm=T)})
  polygon(x=c(1:k, rev(1:k)), y=10^c(mu-se, rev(mu+se)), col=paste(color, "80", sep=""), border=F)
  lines(x=1:k, y=10^mu, lwd=3, col=color)
}

plot(c(0,50), c(1, 1), type='l', ylim=c(150, 2500), xlim=c(0, 50), log='y')
fancyplot(RTdat[[1]], rgb(0, 0.5, 0))
fancyplot(RTdat[[2]], rgb(0.5, 0, 0))
fancyplot(RTdat[[3]], rgb(0.5, 0, 0.5))
fancyplot(RTdat[[4]], rgb(0, 0.5, 0.5))
fancyplot(RTdat[[5]], rgb(0, 0, 0))

plot(c(0,25), c(1, 1), type='l', ylim=c(500, 2500), xlim=c(0, 25), log='y')

fancyplot(RTdat[[2]][,1:25], rgb(0.5, 0, 0))
fancyplot(RTdat[[2]][,26:50], rgb(1.0, 0, 0))
fancyplot(RTdat[[1]][,26:50], rgb(0, 0.5, 0))
fancyplot(RTdat[[4]][,26:50], rgb(0, 0.5, 0.5))
fancyplot(RTdat[[3]][,26:50], rgb(0.5, 0, 0.5))
fancyplot(RTdat[[5]][,26:50], rgb(0, 0, 0))



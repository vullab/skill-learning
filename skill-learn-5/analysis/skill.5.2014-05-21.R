library(tidyverse)

rm(list=ls())
files <- list.files('../data/')

columnnames <- c("RT", "SRmap_0", "SRmap_1", "SRmap_2", "SRmap_3", "SRmap_4", "SRmap_5", "condition", "correct", "correct_response", "curstim", "ms.precue", "ms.prestimblank", "ntrials", "response", "subject", "trial",  "type")
dat = data.frame(row.names = columnnames)

for(f in files){
  q = read.csv2(paste('../data/', f, sep=""), sep=",", header=T, colClasses="character")
  dat <- rbind(dat, q)
}
dat <- dat[!dat$subject=="subject",]
dat$RT <- as.numeric(as.character(dat$RT))
dat$trial <- as.numeric(as.character(dat$trial))
dat$correct <- as.numeric(as.character(dat$correct))
dat$subject <- as.factor(dat$subject)
dat$condition <- as.factor(dat$condition)

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


conditions <- unique(dat$condition)
subjects <- list()
trialmod = 10
blocks = 50

RTdat <- list()
ACdat <- list()
for(c in conditions)
{
  cnum = which(conditions == c)
  subjects[[cnum]] <- unique(dat$subject[dat$condition==c])
  RTdat[[cnum]] <- matrix(data=NA, nrow=length(subjects[[cnum]]), ncol=blocks)
  ACdat[[cnum]] <- matrix(data=NA, nrow=length(subjects[[cnum]]), ncol=blocks)
  for(s in subjects[[cnum]])
  {
    snum = which(subjects[[cnum]] == s)
    for(block in 1:50)
    {
      filter = dat$condition==c & dat$subject==s & (dat$trial <= block*10) & (dat$trial > (block-1)*10)
      myt = dat[filter,]
      ACdat[[cnum]][snum,block] = mean(myt$correct)
      RTdat[[cnum]][snum,block] = mean(myt$RT[myt$correct==1])
    }
#     for(block in 1:blocks)
#     {
#       filter = dat$condition==c & dat$subject==s & (dat$trial <= block+9) & (dat$trial >= block)
#       myt = dat[filter,]
#       ACdat[[cnum]][snum,block] = mean(myt$correct)
#       RTdat[[cnum]][snum,block] = mean(myt$RT[myt$correct==1])
#     }
  }
}

colors = list(rgb(0.5, 0, 0.5), rgb(0, 0.5, 0), rgb(0, 0.5, 0.5), rgb(0.5, 0, 0), rgb(0, 0, 0))

plot(c(-10, blocks+10), c(0,0), ylim=c(0,2), type='l', xlim=c(0, blocks+1), col='black')
for(i in 1:length(conditions)){
  err = apply(ACdat[[i]], 2, sd)/sqrt(nrow(ACdat[[i]]))
  mus = apply(ACdat[[i]], 2, mean)
  polygon(c(1:blocks, blocks:-1:1), c((1-mus)-err, rev((1-mus)+err)), col = paste(colors[[i]], "80", sep=""), lty=0)
  err = apply(RTdat[[i]]/1000, 2, sd)/sqrt(nrow(RTdat[[i]]))
  mus = apply(RTdat[[i]]/1000, 2, mean)
  polygon(c(1:blocks, blocks:-1:1), c(mus-err, rev(mus+err)), col = paste(colors[[i]], "80", sep=""), lty=0)
}

for(i in 1:length(conditions)){
  lines(1-colMeans(as.array(ACdat[[i]]), na.rm=T), col=colors[[i]], lwd=2)
  lines(colMeans(as.array(RTdat[[i]])/1000, na.rm=T), col=colors[[i]], lwd=2)  
}


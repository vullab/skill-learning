rm(list=ls())
files <- list.files('../data/')

s = 1
columnnames <- c("RT", "SRmap_0", "SRmap_1", "SRmap_2", "SRmap_3", "SRmap_4", "SRmap_5", "condition", "correct", "correct_response", "curstim", "ms.precue", "ms.prestimblank", "ntrials", "response", "subject", "trial",  "type")
dat = data.frame(row.names = columnnames)

for(f in files){
  q = read.csv2(paste('../data/', f, sep=""), sep=",", header=T)
  q$subject = s
  n = nrow(q)
  q$trial = 1:n
  names(q) <- columnnames
  dat <- rbind(dat, q)
  s = s+1
}

dat$RT <- as.numeric(as.character(dat$RT))


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
      ACdat[[cnum]][snum,block] = mean(myt$correct)
      RTdat[[cnum]][snum,block] = mean(as.numeric(as.character(myt$RT[myt$correct==1])))
    }
  }
}

colors = list(rgb(0, 0.5, 0), rgb(0.5, 0, 0), rgb(0.5, 0, 0.5), rgb(0, 0.5, 0.5))

plot( 1-colMeans(as.array(ACdat[[1]]), na.rm=T), ylim=c(0,2.5), type='l', col=colors[[1]])
lines(1-colMeans(as.array(ACdat[[2]]), na.rm=T), col=colors[[2]])
lines(1-colMeans(as.array(ACdat[[3]]), na.rm=T), col=colors[[3]])
lines(1-colMeans(as.array(ACdat[[4]]), na.rm=T), col=colors[[4]])

lines(colMeans(as.array(RTdat[[1]])/1000, na.rm=T), col=colors[[1]])
lines(colMeans(as.array(RTdat[[2]])/1000, na.rm=T), col=colors[[2]])
lines(colMeans(as.array(RTdat[[3]])/1000, na.rm=T), col=colors[[3]])
lines(colMeans(as.array(RTdat[[4]])/1000, na.rm=T), col=colors[[4]])




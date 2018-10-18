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


conditions <- unique(dat$condition)
subjects <- list()

R2P <- function(x){1/(1+exp(-x))}
edecay <- function(t, a, b, tau){pmax(1, 10^a+10^b*exp(-(t/(10^tau))))}
loss <- function(pred,y, a, b){sum(pmin(1.5, (log(pred)-log(y))^2))+b^2}
fits <- list()

for(c in conditions)
{
  cnum = which(conditions == c)
  subjects[[cnum]] <- unique(dat$subject[dat$condition==c])
  fits[[cnum]] <- matrix(data=NA, nrow=length(subjects[[cnum]]), ncol=6)
  for(s in subjects[[cnum]])
  {
    snum = which(subjects[[cnum]] == s)
    filter = dat$condition==c & dat$subject==s
    myt = dat[filter,]
    C <- myt$correct==1 & myt$type=="train"
    trials = myt$trial[C]
    rts <- pmax(1, myt$RT[C])
    nLL <- function(a, b, tau){loss(rts, edecay(trials, a, b, tau), a, b)}
    fit1 = NULL
    while(is.null(fit1)){
      try(fit1 <- mle(nLL, start=list(a=rnorm(1, 3, 1), b=rnorm(1, 3, 1), tau=rnorm(1, 3, 1))), silent=T)
    }
    C <- myt$correct==1 & myt$type=="test"
    trials = myt$trial[C]-250
    rts <- pmax(1, myt$RT[C])
    nLL <- function(a, b, tau){loss(rts, edecay(trials, a, b, tau), a, b)}
    fit2 = NULL
    while(is.null(fit2)){
      try(fit2 <- mle(nLL, start=list(a=rnorm(1, 3, 1), b=rnorm(1, 3, 1), tau=rnorm(1, 3, 1))), silent=T)
    }
    
    fits[[cnum]][snum,] <- c(fit1@coef, fit2@coef)
  }
}
    
  
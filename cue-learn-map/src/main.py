#!/usr/bin/env python
from __future__ import division

import drawer
import timer
import recorder
import scorer
from configurer import *
import time
from inputter import *
from numpy import *
from includes import *

datapath = os.path.join('..','data')
confpath = os.path.join('..','conf')

random.seed()

subjectid = ""; sessionid = ""

while subjectid=="" or subjectid==None:
	subjectid = raw_input("Subject ID: ")
	print subjectid
sessionid=0

random.seed(subjectid+str(time.time()))

drawer = drawer.Drawer()
scorer = scorer.Scorer()

acceptedkeys = ['s', 'd', 'f', 'j', 'k', 'l']

sessionid = 0
exptname = "skill3"

gensettings = readConfig(os.path.join(confpath,'configuration.txt'))
colort = readConfig(os.path.join(confpath,'colors.txt'))
colors = []
for k,v in colort.iteritems():
	colors.append(map(int, v))
print colors
letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
colidx = range(0,5)
letidx = range(0,26)

# assign random between-subject noise condition
gensettings['condition'] = random.choice(['E+','E-','H+','H-','M'])

def showFeedback(fbtext, delay):
	drawer.fillScreen((0,0,0))
	for i in range(0,len(fbtext)):
		drawer.writeText(fbtext[i], (5,100+30*i))
	if delay == 0:
		drawer.writeText('Press any button to continue', (5,100+30*len(fbtext)))
		drawer.flip()
		waitforkey()
	else:
		drawer.writeText('Waiting %d miliseconds...'%delay, (5,100+30*len(fbtext)))
		drawer.flip()
		time.sleep(delay/1000)
		drawer.writeText('Press any button to continue', (5,100+30*(len(fbtext)+1)))
		drawer.flip()
		waitforkey()
		

def showInstructions(insfile='instructions.txt'):
	fid = open(insfile,'r')
	insttext = []
	for line in fid:
		insttext.append(line.rstrip('\n'))
	fid.close()
	showFeedback(insttext,0)

def oneTrial(trialdata):
	# clear events
	trialtimer = timer.Timer()
	found = processEvents(pygame.event.get(), (None,))
	if -999 in found:
		quit()
	
	
	if trialdata['condition']=='E+' or trialdata['condition']=='E-':
		trialdata['ms-prestimblank'] = 1000
		trialdata['ms-precue'] = 1000
	else:
		trialdata['ms-prestimblank'] = 2000
		trialdata['ms-precue'] = 0
	
	trialdata['curstim'] = random.sample([0,1,2,3,4,5],1)[0]
	trialdata['correct_response'] = trialdata['SRmap_%d'%trialdata['curstim']]
	
	# draw initial fixation / blank screen
	drawer.fillScreen((255,255,255))
	drawer.drawFixation((0,0), [0,0,0])
	drawer.flip()
	trialtimer.start()
	
	# blank screen
	drawer.fillScreen((255,255,255))
	drawer.drawFixation((0,0), [0,0,0])
	drawer.flip()
	trialtimer.record('cueblank')
	trialtimer.record('precue')
	time.sleep(trialdata['ms-prestimblank']/1000)
	
	if trialdata['condition']=='E+' or trialdata['condition']=='E-':
		# display pre-cue
		drawer.fillScreen((255,255,255))
		curletter = acceptedkeys[trialdata['SRmap_%d'%trialdata['curstim']]]
		drawer.writeText('prepare to make response %s'%curletter, (300,600), (0,0,0))
		drawer.flip()
		trialtimer.record('precue')
		time.sleep(trialdata['ms-precue']/1000)
	
	# blank screen
	drawer.fillScreen((255,255,255))
	drawer.drawImage(trialdata['curstim'], (0,0))
	drawer.flip()
	trialtimer.record('stimon')
	
	response = waitforresp(acceptedkeys)
	trialtimer.record('response')
	
	trialdata['RT'] = trialtimer.getreltime('response', 'stimon')*1000
	
	if response == -999:
		quit()
	elif trialdata['correct_response'] == response:
		trialdata['response'] = response
		trialdata['correct'] = 1
		feedbacktext = ['Correct!','Your response time was %d milliseconds'%int(trialdata['RT']),'Go as fast as you can!']
		delay = 0
	else:
		trialdata['response'] = response
		trialdata['correct'] = 0
		feedbacktext = ['Wrong.','The correct response was %s'%int(acceptedkeys[trialdata['correct_response']]),'Make sure to hit the right button.']
		delay = 3000
	
	time.sleep(1)
	
	showFeedback(feedbacktext, delay)
	
	return trialdata

def runExpt(ntrials):
	filename = '%s-%s_%d.txt' % (exptname, subjectid, sessionid)
	filepath = os.path.join(datapath,filename)
	
	mapping = [0,1,2,3,4,5]
	random.shuffle(mapping)
	
	for t in range(0,ntrials):
		trialdata = dict(gensettings)
		for k,v in trialdata.iteritems():
			if isinstance(v,(list,tuple)):
				# print 'randomly sampling %s from '%k + str(v)
				trialdata[k] = random.sample(v,1)[0]
		for i in range(0,6):
			trialdata['SRmap_%d'%i]=mapping[i]
		trialdata = oneTrial(trialdata)
		if t==0:
			trialwriter = recorder.Recorder(filepath, trialdata)
		trialwriter.write(trialdata)
	
	trialwriter.close()
	print('Total points: %d' % scorer.view()[0])
		
	
showInstructions(os.path.join(confpath,'instructions.txt'))
sessionid=0
runExpt(2)
sessionid=1
showInstructions(os.path.join(confpath,'instructions2.txt'))
runExpt(gensettings['ntrials'])
# actual experiment!



quit()

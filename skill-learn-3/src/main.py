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

bgcol = (255,255,255)
fgcol = (0,0,0)
corcol = (0,168,0)
wrocol = (168,0,0)
textsx = 50
textsy = 100
textiy = 30
fbsx = 300
fbsy = 500
fbiy = 30
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
gensettings['condition'] = random.choice(['E+','E-','H+','H-'])

def showFeedback(fbtext, delay):
	# drawer.fillScreen(bgcol)
	for i in range(0,len(fbtext)):
		drawer.writeText(fbtext[i], (textsx,textsy+textiy*i), fgcol)
	drawer.flip()
	waitforkey()

def showInstructions(insfile='instructions.txt'):
	fid = open(insfile,'r')
	insttext = []
	for line in fid:
		insttext.append(line.rstrip('\n'))
	fid.close()
	drawer.fillScreen(bgcol)
	showFeedback(insttext,0)

def drawAnswerKey(trialdata):
	xspace = 1024/len(acceptedkeys)
	for i in range(0,len(acceptedkeys)):
		ridx = trialdata['SRmap_%d'%i]
		drawer.drawThumb(i, ((ridx+0.5)*xspace-1024/2,360))
		drawer.writeText('%d (%s)' % ((ridx+1), acceptedkeys[ridx]), ((ridx+0.5)*xspace-20,680), fgcol)

def oneTrial(trialdata):
	# clear events
	trialtimer = timer.Timer()
	found = processEvents(pygame.event.get(), (None,))
	if -999 in found:
		quit()
	
	if trialdata['type']=='train' and (trialdata['condition']=='E+' or trialdata['condition']=='E-'):
		trialdata['ms-prestimblank'] = 600
		trialdata['ms-precue'] = 400
	else:
		trialdata['ms-prestimblank'] = 1000
		trialdata['ms-precue'] = 0
	
	trialdata['curstim'] = random.sample([0,1,2,3,4,5],1)[0]
	trialdata['correct_response'] = trialdata['SRmap_%d'%trialdata['curstim']]
	
	# draw initial fixation / blank screen
	drawer.fillScreen(bgcol)
	drawer.drawFixation((0,0), fgcol)
	drawer.flip()
	trialtimer.start()
	
	# blank screen
	drawer.fillScreen(bgcol)
	drawer.drawFixation((0,0), fgcol)
	drawer.flip()
	trialtimer.record('cueblank')
	trialtimer.record('precue')
	time.sleep(trialdata['ms-prestimblank']/1000)
	
	drawer.fillScreen(bgcol)
	if trialdata['condition']=='E+' or trialdata['condition']=='E-':
		# display pre-cue
		curletter = acceptedkeys[trialdata['SRmap_%d'%trialdata['curstim']]]
		print trialdata['correct_response']
		print trialdata['correct_response']+1
		drawer.writeText('Button: %d ...'%(trialdata['correct_response']+1), (400,450), fgcol)
		drawer.flip()
		trialtimer.record('precue')
		time.sleep(trialdata['ms-precue']/1000)
	
	found = processEvents(pygame.event.get(), (None,))
	if -999 in found:
		quit()
	# blank screen
	drawer.drawImage(trialdata['curstim'], (0,0))
	drawAnswerKey(trialdata)
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
		drawer.writeText('Correct!', (fbsx,fbsy+fbiy*0), corcol)
		drawer.writeText('Your response time was %d milliseconds'%int(trialdata['RT']), (fbsx,fbsy+fbiy*1), corcol)
		drawer.writeText('Go as fast as you can!', (fbsx,fbsy+fbiy*2), corcol)
		drawer.flip()
		time.sleep(1)
		
		found = processEvents(pygame.event.get(), (None,))
		if -999 in found:
			quit()
		drawer.writeText('Press any button to continue', (fbsx,fbsy+fbiy*3), corcol)
		drawer.flip
		waitforkey()
		
	else:
		trialdata['response'] = response
		trialdata['correct'] = 0
		drawer.writeText('Wrong button!', (fbsx,fbsy+fbiy*0), wrocol)
		drawer.writeText('Make sure to make the correct response', (fbsx,fbsy+fbiy*2), wrocol)
		drawer.flip()
		time.sleep(3)
		
		found = processEvents(pygame.event.get(), (None,))
		if -999 in found:
			quit()
		drawer.writeText('Press any button to continue', (fbsx,fbsy+fbiy*3), wrocol)
		drawer.flip
		waitforkey()
	
	return trialdata

def runExpt(ntrials):
	filename = '%s-%s_%d.txt' % (exptname, subjectid, sessionid)
	filepath = os.path.join(datapath,filename)
	
	mapping = [0,1,2,3,4,5]
	random.shuffle(mapping)
	
	for t in range(0,ntrials):
		if mod(t,30)==29:
			showInstructions(os.path.join(confpath,'instructions2.txt'))
		trialdata = dict(gensettings)
		for k,v in trialdata.iteritems():
			if isinstance(v,(list,tuple)):
				# print 'randomly sampling %s from '%k + str(v)
				trialdata[k] = random.sample(v,1)[0]
		for i in range(0,6):
			trialdata['SRmap_%d'%i]=mapping[i]
		trialdata['type'] = 'train'
		trialdata = oneTrial(trialdata)
		if t==0:
			trialwriter = recorder.Recorder(filepath, trialdata)
		trialwriter.write(trialdata)
	
	if gensettings['condition']=='E-' or gensettings['condition']=='H-':
		mapping = [0,1,2,3,4,5]
		random.shuffle(mapping)
	
	showInstructions(os.path.join(confpath,'instructions3.txt'))
	
	for t in range(ntrials,ntrials*2):
		if mod(t,30)==29:
			showInstructions(os.path.join(confpath,'instructions2.txt'))
		trialdata = dict(gensettings)
		for k,v in trialdata.iteritems():
			if isinstance(v,(list,tuple)):
				# print 'randomly sampling %s from '%k + str(v)
				trialdata[k] = random.sample(v,1)[0]
		for i in range(0,6):
			trialdata['SRmap_%d'%i]=mapping[i]
		trialdata['type'] = 'test'
		trialdata = oneTrial(trialdata)
		if t==0:
			trialwriter = recorder.Recorder(filepath, trialdata)
		trialwriter.write(trialdata)
		
	trialwriter.close()
	
showInstructions(os.path.join(confpath,'instructions.txt'))
sessionid=0
runExpt(gensettings['ntrials'])

# actual experiment!



quit()

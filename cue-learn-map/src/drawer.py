#!/Library/Frameworks/Python.framework/Versions/Current/bin/python
from __future__ import division
import OpenGL.GL as gl
import pygame
from pygame.locals import *
import pygame.image
from numpy import *
import colorsys
pygame.font.init()


class Drawer(object):
	def __init__(self):
		self.screen = pygame.display.set_mode((1024, 768), pygame.FULLSCREEN)#16) # pygame.FULLSCREEN
		self.center = (512,368)
		self.deg2pix = 30
		self.xlim = (0, 1024)
		self.ylim = (0,768)
		self.gainmag = 40
		self.font = pygame.font.Font(None, 36)
		self.textDic = {}
		self.stimfont = pygame.font.Font('../stimuli/Sloan.otf', 24) #../stimuli/Sloan.otf
		
		self.images = []
		for i in range(0,6):
			self.images.append(pygame.image.load('../img/%d.jpg'%(i+1)))

	def writeText(self, text, pos, col=(255,255,255)):
		if not self.textDic.has_key(text):
			self.textDic[text] = self.font.render(text, 1, col)
		self.screen.blit(self.textDic[text], pos)

	def drawImage(self, idx, center):
		(w,h) = self.images[idx].get_size()
		pos = (center[0]-w/2+self.center[0], center[1]-h/2+self.center[1])
		self.screen.blit(self.images[idx], pos)
		self.flip()

	def drawLetter(self, center=(0,0), let='X', col=[0,0,0]):
		#  (let, col)
		cx = center[0]*self.deg2pix+self.center[0]; cy = center[1]*self.deg2pix+self.center[1]
		sz = self.stimfont.size(let)
		curstim = self.stimfont.render(let, 1, col)
		self.screen.blit(curstim, (cx-sz[0]/2, cy-sz[1]/2))
		
	def drawLetterAbs(self, center=(0,0), let='X', col=[0,0,0]):
		cx = center[0]
		cy = center[1]
		sz = self.stimfont.size(let)
		curstim = self.stimfont.render(let, 1, col)
		self.screen.blit(curstim, (cx-sz[0]/2, cy-sz[1]/2))

	def drawFixation(self, fixation, color=(0,0,0)):
		pygame.draw.circle(self.screen, color, (fixation[0]*self.deg2pix+self.center[0], fixation[1]*self.deg2pix+self.center[1]), 5)
	
	def fillScreen(self, col=(255,255,255)):
		self.screen.fill(col)
	
	def flip(self):
		pygame.display.flip()
	

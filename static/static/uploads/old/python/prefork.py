#!/usr/local/bin/python


import os
import signal
import time


child_count = 0


def child_die(signum,frame):
	global child_count
	os.wait()
	child_count -= 1


def prefork(child_process, child_max=5):
	global child_count

	signal.signal(signal.SIGCHLD,child_die)

	while 1:
		if ( child_count < child_max):
			r = os.fork()
			if (r==0):
				child_process()
				return
			elif (r>0):
				child_count +=1
				print "Child process created:", child_count
			else:
				print "Fork Error"
		time.sleep(1)


# ================================================
if __name__=='__main__':
	def my_handler():
		print "Child Waiting"
		time.sleep(10)
		print "Child End"
	
	prefork(my_handler)




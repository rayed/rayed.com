---
title: IPython Import Error
author: Rayed
type: post
date: 2013-08-24T01:44:52+03:00
categories:
  - Uncategorized
tags:
  - python
  - ubuntu
wordpress_id: 1368

---
I tried to install IPython to play with it and learn more about scientific Python packages, but I faced an error on my first step:

<!--more-->

    (env)rayed@ubuntu:~$ sudo aptitude ipython
    (env)rayed@ubuntu:~$ ipython
    Traceback (most recent call last):
      File "/usr/bin/ipython", line 5, in <module>
        from IPython.frontend.terminal.ipapp import launch_new_instance
    ImportError: No module named IPython.frontend.terminal.ipapp</module>

after 30 minutes of searching the net without any clues I figured it out, the problem was with my Python "VirtualEnv" setup, I setup my account to use a default virtual enviroument that was created earlier without the IPython packages, which means the python command doesn't know about IPython! solving it was easy just "deactivate" the virtual env and it worked.

    (env)rayed@ubuntu:~$ deactivate
    rayed@ubuntu:~$ ipython
    Python 2.7.3 (default, Apr 10 2013, 06:20:15) 
    Type "copyright", "credits" or "license" for more information.

    IPython 0.12.1 -- An enhanced Interactive Python.
    ?         -> Introduction and overview of IPython's features.
    %quickref -> Quick reference.
    help      -> Python's own help system.
    object?   -> Details about 'object', use 'object??' for extra details.

    In [1]: 


#### Tip

I installed IPython on my server, but I wanted to access it from my Mac, to achieve this securely I created an "ssh" tunnel from localhost port 8888 to the server localhost port 8888 then start IPython notebook on the server

    osx$ ssh server -L 8888:127.0.0.1:8888
    $ ipython notebook
    [NotebookApp] The IPython Notebook is running at: http://127.0.0.1:8888

Now I can access it locally using:
(http://localhost:8888/)


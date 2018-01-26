---
title: Managing Python Environments with “virtualenvwrapper”
author: Rayed
type: post
date: 2013-04-02T09:48:33+03:00
categories:
  - Uncategorized
tags:
  - pip
  - python
  - virtualenv
wordpress_id: 1142

---


### What is virtualenvwrapper

virtualenvwrapper is a tool that (as the name suggest) wrap "<a href="http://www.virtualenv.org/">virtualenv</a>" program, virtualenv solve the following problem:

<!--more-->

> The basic problem being addressed is one of dependencies and versions, and indirectly permissions. Imagine you have an application that needs version 1 of LibFoo, but another application requires version 2. How can you use both these applications? If you install everything into /usr/lib/python2.7/site-packages (or whatever your platform’s standard location is), it’s easy to end up in a situation where you unintentionally upgrade an application that shouldn’t be upgraded.

"virtualenvwrapper" will is simple wrapper that allows to create virtual environments and switch between them easily!


### Installation

First we will make sure "pip" is installed (system wide), then install "virtualenvwrapper" using "pip":

    $ sudo aptitude install python-pip
    $ sudo pip install virtualenvwrapper

If you don't have root access try: <em>pip install -install-option="-user" virtualenvwrapper</em>

Then you need to add "virtualenvwrapper" to your startup script, ".bashrc" if you are using bash (most OS use it by default):

    $ vi ~/.bashrc
    # add the following at the end
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh


### Usage:

We will make new virtualenv named "myenv1" and install Django 1.4 on it:

    rayed@ubuntu:$ mkvirtualenv myenv1
    (myenv1)rayed@ubuntu:$ 
    (myenv1)rayed@ubuntu:$ pip install django==1.4
    (myenv1)rayed@ubuntu:$ pip freeze
    Django==1.4

*"pip freeze" list all installed Python packages*

Now we will make a new environment "myenv2" and install latest Django on it:

    (myenv1)rayed@ubuntu:$ mkvirtualenv myenv2
    (myenv2)rayed@ubuntu:$ 
    (myenv2)rayed@ubuntu:$ pip install django
    (myenv2)rayed@ubuntu:$ pip freeze
    Django==1.5

Now we have 2 isolated environment each with its own version of Python packages.

Now you can use "workon" command to switch between them:

    (myenv2)rayed@ubuntu:$ workon myenv1
    (myenv1)rayed@ubuntu:$ pip freeze
    Django==1.4
    (myenv1)rayed@ubuntu:$ workon myenv2
    (myenv2)rayed@ubuntu:$ pip freeze
    Django==1.5

To list all created virtualenvironment use the command:

    rayed@ubuntu:$ workon
    myenv1
    myenv2

A neat little trick is to associate a dir with a virtualenv, using the commands "setvirtualenvproject":

    (myenv1)rayed@ubuntu:~$ cd my_django_site
    (myenv1)rayed@ubuntu:~/my_django_site$ setvirtualenvproject

So next time you switch to "myenv1" it will automatically switch to "my_django_site" directory.

When you don't need a virtualenv any more just delete it:

  (myenv1)rayed@ubuntu:~$ deactivate
  rayed@ubuntu:~$ rmvirtualenv myenv1


### Open Questions?

By default "virtualenvwrapper" doesn't include system installed site packages and start with fresh set of packages (almost), which is fine for most package, but some packages have many large complex dependencies which make installing them using pip very lengthy and hard process, example for these packages MySQLdb, PIL, psycopg2, this why I prefer to install them using system package manager (aptitude in Ubuntu).

You can pass "-system-site-packages" to mkvirtualenv command:

    mkvirtualenv --system-site-packages  mytest1

Or make the default behaviour: 

    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--system-site-packages'

But in this case we will import ALL Python system packages!

A dirty work around is to link 

    (myenv1)rayed@s1:~$ cdsitepackages
    (myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ ln -s /usr/lib/python2.7/dist-packages/_mysql* .
    (myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ ln -s /usr/lib/python2.7/dist-packages/MySQLdb 
    (myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ ln -s /usr/lib/python2.7/dist-packages/PIL 
    (myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ cdproject
    (myenv1)rayed@s1:~$ 

To automate this process with new virtualenv add the commands to "postmkvirtualenv" hook:

    rayed@s1:~$ cat >> ~/.python_envs/postmkvirtualenv

    # Link MySQLdb and PIL from system packages
    OLDPWD=`pwd`
    cdsitepackages
    ln -s /usr/lib/python2.7/dist-packages/_mysql* .
    ln -s /usr/lib/python2.7/dist-packages/MySQLdb  .
    ln -s /usr/lib/python2.7/dist-packages/PIL  .
    cd $OLDPWD


### Thank You

I learned about virtualenvwrapper from <a href="https://django.2scoops.org/">Two Scoops of Django</a> book which is great e-book about Django development, and also from <a href="http://yr.sa/">Yasser Alraddadi</a>, Thank you guys


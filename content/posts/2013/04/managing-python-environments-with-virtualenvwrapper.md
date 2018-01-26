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
<h2>What is virtualenvwrapper</h2>
<p>virtualenvwrapper is a tool that (as the name suggest) wrap &#8220;<a href="http://www.virtualenv.org/">virtualenv</a>&#8221; program, virtualenv solve the following problem:</p>
<blockquote><p>The basic problem being addressed is one of dependencies and versions, and indirectly permissions. Imagine you have an application that needs version 1 of LibFoo, but another application requires version 2. How can you use both these applications? If you install everything into /usr/lib/python2.7/site-packages (or whatever your platform’s standard location is), it’s easy to end up in a situation where you unintentionally upgrade an application that shouldn’t be upgraded.</p></blockquote>
<p>&#8220;virtualenvwrapper&#8221; will is simple wrapper that allows to create virtual environments and switch between them easily!<br />
<!--more--></p>
<h2>Installation</h2>
<p>First we will make sure &#8220;pip&#8221; is installed (system wide), then install &#8220;virtualenvwrapper&#8221; using &#8220;pip&#8221;:</p>
<pre><code>$ sudo aptitude install python-pip
$ sudo pip install virtualenvwrapper
</code></pre>
<p>If you don&#8217;t have root access try: <em>pip install &#8211;install-option=&#8221;&#8211;user&#8221; virtualenvwrapper</em></p>
<p>Then you need to add &#8220;virtualenvwrapper&#8221; to your startup script, &#8220;.bashrc&#8221; if you are using bash (most OS use it by default):</p>
<pre><code>$ vi ~/.bashrc
# add the following at the end
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
</code></pre>
<h2>Usage:</h2>
<p>We will make new virtualenv named &#8220;myenv1&#8221; and install Django 1.4 on it:</p>
<pre><code>rayed@ubuntu:$ mkvirtualenv myenv1
(myenv1)rayed@ubuntu:$ 
(myenv1)rayed@ubuntu:$ pip install django==1.4
(myenv1)rayed@ubuntu:$ pip freeze
Django==1.4
</code></pre>
<p><small>&#8220;pip freeze&#8221; list all installed Python packages</small></p>
<p>Now we will make a new environment &#8220;myenv2&#8221; and install latest Django on it:</p>
<pre><code>(myenv1)rayed@ubuntu:$ mkvirtualenv myenv2
(myenv2)rayed@ubuntu:$ 
(myenv2)rayed@ubuntu:$ pip install django
(myenv2)rayed@ubuntu:$ pip freeze
Django==1.5
</code></pre>
<p>Now we have 2 isolated environment each with its own version of Python packages.</p>
<p>Now you can use &#8220;workon&#8221; command to switch between them:</p>
<pre><code>(myenv2)rayed@ubuntu:$ workon myenv1
(myenv1)rayed@ubuntu:$ pip freeze
Django==1.4
(myenv1)rayed@ubuntu:$ workon myenv2
(myenv2)rayed@ubuntu:$ pip freeze
Django==1.5
</code></pre>
<p>To list all created virtualenvironment use the command:</p>
<pre><code>rayed@ubuntu:$ workon
myenv1
myenv2
</code></pre>
<p>A neat little trick is to associate a dir with a virtualenv, using the commands &#8220;setvirtualenvproject&#8221;:</p>
<pre><code>(myenv1)rayed@ubuntu:~$ cd my_django_site
(myenv1)rayed@ubuntu:~/my_django_site$ setvirtualenvproject
</code></pre>
<p>So next time you switch to &#8220;myenv1&#8221; it will automatically switch to &#8220;my_django_site&#8221; directory.</p>
<p>When you don&#8217;t need a virtualenv any more just delete it:</p>
<pre><code>(myenv1)rayed@ubuntu:~$ deactivate
rayed@ubuntu:~$ rmvirtualenv myenv1
</code></pre>
<h2>Open Questions?</h2>
<p>By default &#8220;virtualenvwrapper&#8221; doesn&#8217;t include system installed site packages and start with fresh set of packages (almost), which is fine for most package, but some packages have many large complex dependencies which make installing them using pip very lengthy and hard process, example for these packages MySQLdb, PIL, psycopg2, this why I prefer to install them using system package manager (aptitude in Ubuntu).</p>
<p>You can pass &#8220;&#8211;system-site-packages&#8221; to mkvirtualenv command:</p>
<pre><code>mkvirtualenv --system-site-packages  mytest1</code></pre>
<p>Or make the default behaviour: </p>
<pre><code>export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--system-site-packages'</code></pre>
<p>But in this case we will import ALL Python system packages!</p>
<p>A dirty work around is to link package manually:</p>
<pre><code>(myenv1)rayed@s1:~$ cdsitepackages
(myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ ln -s /usr/lib/python2.7/dist-packages/_mysql* .
(myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ ln -s /usr/lib/python2.7/dist-packages/MySQLdb 
(myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ ln -s /usr/lib/python2.7/dist-packages/PIL 
(myenv1)rayed@s1:~/.virtualenvs/myenv1/lib/python2.7/site-packages$ cdproject
(myenv1)rayed@s1:~$ 
</code></pre>
<p>To automate this process with new virtualenv add the commands to &#8220;postmkvirtualenv&#8221; hook:</p>
<pre><code>rayed@s1:~$ cat >> ~/.python_envs/postmkvirtualenv

# Link MySQLdb and PIL from system packages
OLDPWD=`pwd`
cdsitepackages
ln -s /usr/lib/python2.7/dist-packages/_mysql* .
ln -s /usr/lib/python2.7/dist-packages/MySQLdb  .
ln -s /usr/lib/python2.7/dist-packages/PIL  .
cd $OLDPWD
</code></pre>
<h2>Thank You</h2>
<p>I learned about virtualenvwrapper from <a href="https://django.2scoops.org/">Two Scoops of Django</a> book which is great e-book about Django development, and also from <a href="http://yr.sa/">Yasser Alraddadi</a>, Thank you guys</p>

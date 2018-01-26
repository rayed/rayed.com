---
title: 'My New Project: AgentX Implementation in Python'
author: Rayed
type: post
date: 2013-10-16T23:15:47+03:00
categories:
  - Uncategorized
tags:
  - agentx
  - cacti
  - linux
  - monitoring
  - net-snmp
  - network
  - nms
  - python
  - snmp
wordpress_id: 1414

---

During this Eid vacation I spent many hours working on AgentX implementation in Python.

You can find the project in <a href="https://github.com/">GitHub</a>:

(https://github.com/rayed/pyagentx)

<!--more-->

**Update:** I changed the module name to "pyagentx", thank you Daniel for the suggestion.


### What is AgentX?
AgentX is protocol to extend SNMP agents, defined in <a href="http://www.ietf.org/rfc/rfc2741.txt">RFC 2741</a>.

But what is SNMP? let's say you have a Linux machine you want to monitor, you will use <a href="http://en.wikipedia.org/wiki/Simple_Network_Management_Protocol">Simple Network Management Protocol</a> or SNMP for short, you install an SNMP agent on the machine like <a href="http://net-snmp.sourceforge.net/">Net-SNMP</a>, and from your management station you connect to the SNMP agent and ask it for the data you want report on, for example the current state of network link.

What happen if you install new software, like PostgreSQL DB, and your SNMP agent doesn't support it, how can you monitor it! The good news SNMP agents (e.g. Net-SNMP) can be extend with multiple options, the bad news most options are very hard.

One of the most flexible options is AgentX protocol, you will need to build an application that run AgentX protocol (AgentX SubAgent), upon startup it will contact the SNMP agent (AgentX master) and register a part of the MIB tree that your app will handle, the SNMP agent (AgentX master) will forward all queries to your app which will return the result back to the master which will forward it to the management station (Cacti, NMS).

Net-SNMP already have an API to build AgentX Sub Agent, and there are <a href="http://sourceforge.net/projects/python-agentx/">Python module</a> that utilise it, but unfortunately it doesn't look active, and as far as I know Net-SNMP API it self isn't the easiest thing to work with.

This is why I started working with Pure Python implementation for AgentX protocol, it is already in a working condition and tested with Net-SNMP agent, I've some more issues to resolve before I can use it in production.

So please if you are interested in the field give my module a try, and let me know how can improve it, and also suggest better name.


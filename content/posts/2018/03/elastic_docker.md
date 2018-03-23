---
title: "Playing with Elasticsearch & Kibana in Docker"
date: 2018-03-21T10:08:38+03:00
type: post
tags: 
    - linux
    - elastic
    - kibana
    - docker
---

An easy way to start an [Elasticsearch](https://www.elastic.co/products/elasticsearch) server with [Kibana](https://www.elastic.co/products/kibana) (Elasticsearch frontend) instance!

<!--more-->

First I write the following `docker-compose.yml` file:

    version: "3"
    services:

        elasticsearch:
            image: docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3
            environment:
                discovery.type: single-node
            volumes:
                - elastic-data:/usr/share/elasticsearch/data
            ports:
                - 9200:9200
            networks:
                - backend

        kibana:
            image: docker.elastic.co/kibana/kibana-oss:6.2.3
            depends_on:
                - elasticsearch
            ports:
                - 5601:5601
            networks:
                - backend

    networks:
        backend:

    volumes:
        elastic-data:


Then to start it:

    docker-compose up -d 

and stop it:

    docker-compose stop


You can access both server from the browser:

- Elasticsearch <http://localhost:9200/>
- Kibana <http://localhost:5601/>


---
title: "Build small Go Program Docker Image"
date: 2021-07-06T10:00:04+03:00
type: post
---

Let's start with this small Go program:

    package main

    import (
            "fmt"
    )

    func main() {
            fmt.Println("Marhaba")
    }


You can run it without installing Go on your machine using Docker:

    docker run --rm -it   -v `pwd`:/myapp -w /myapp golang:1.16   go run app.go


## Building a Docker Image

Next step we will make a custom Docker image from our application, we would need a `Dockerfile` like this:

    From golang:1.16

    WORKDIR /go/src/app
    COPY . .

    RUN go build -o app app.go

    CMD ["./app"]


To build it:

    docker build  -t myapp .

After having our own image it is time to run it:

    docker run --rm myapp 


## Building a *Small* Docker Image

If we check the size of our image:

    $ docker images myapp
    REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
    myapp        latest    f0d7b156c7e1   3 minutes ago   866MB

WOW! 866MB for a `hello world` program!

The problem is that we based our image on Golang docker image, which contains many things
including the compilers.

To solve this issue, we can utilize [multi-stage build](https://docs.docker.com/develop/develop-images/multistage-build/),
one stage for building, another for the image it self. 

To do it we change the `Dockerfile`:

    # Stage 1: compile the program
    FROM golang:1.16
    WORKDIR /go/src/app
    COPY app.go .
    RUN go build -o app app.go

    # Stage 2: build the image
    FROM alpine:latest  
    RUN apk --no-cache add ca-certificates
    WORKDIR /root/
    COPY --from=0 /go/src/app .
    CMD ["./app"]  

Now let's build the image using and check its size:

    $ docker build  -t myapp .
    $ docker images myapp
    REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
    myapp        latest    ded25480ca29   46 seconds ago   8.03MB

The docker image went from 866 MB to only 8 MB!

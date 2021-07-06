---
title: "Build small Go Program Docker Image"
date: 2021-07-06T10:00:04+03:00
type: post
---

Let's start with this small Go program:

    package main

    import "github.com/gin-gonic/gin"

    func main() {
        r := gin.Default()
        r.GET("/ping", func(c *gin.Context) {
            c.JSON(200, gin.H{
                "message": "pong",
            })
        })
        r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
    }

We will use go modules to manage dependencies:

    go mod init rayed.com/server
    go mod tidy

You can run it without installing Go on your machine using Docker:

    docker run --rm -it   -v `pwd`:/app -w /app golang:1.16   go run server.go


## Building a Docker Image

Next step we will make a custom Docker image from our application, we would need a `Dockerfile` like this:

    From golang:1.16

    WORKDIR /go/src/app
    COPY . .

    RUN go build -o server server.go

    CMD ["./server"]


To build it:

    docker build  -t myapp .

After having our own image it is time to run it:

    docker run --rm -p 8080:8080 myapp 


## Building a *Small* Docker Image

If we check the size of our image:

    $ docker images myapp
    REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
    myapp        latest    f0d7b156c7e1   3 minutes ago   866MB

WOW! 866MB for a small program!

The problem is that we based our image on Golang docker image, which contains many things
including the compilers.

To solve this issue, we can utilize [multi-stage build](https://docs.docker.com/develop/develop-images/multistage-build/),
one stage for building, another for the image it self. 

To do it we change the `Dockerfile`:

    # Stage 1: compile the program
    FROM golang:1.16 as build-stage
    WORKDIR /app
    COPY go.* .
    RUN go mod download
    COPY . .
    RUN go build -o server server.go

    # Stage 2: build the image
    FROM alpine:latest  
    RUN apk --no-cache add ca-certificates libc6-compat
    WORKDIR /app/
    COPY --from=build-stage /app/server .
    EXPOSE 8080
    CMD ["./server"]  

Now let's build the image using and check its size:

    $ docker build  -t myapp .
    $ docker images myapp
    REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
    myapp        latest    ded25480ca29   46 seconds ago   15.6MB

The docker image went from 866 MB to only 15.6 MB!

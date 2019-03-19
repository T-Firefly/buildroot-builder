# Docker container for Buildroot building

This is a Docker container for Buildroot building. It was created to support the Firefly Open Source Project.  

## Development board supported:  

* [ROC-RK3308-CC](http://en.t-firefly.com/product/rocrk3308cc?theme=pc)

It currently only supports to ROC-RK3308-CC Buildroot SDK.  

## Generating a Docker image

1. Get the project  
```
$ git clone https://github.com/T-Firefly/buildroot-builder.git
```
2. Go into root of buildroot-builder  
```
$ cd buildroot-builder
```
3. Generating a Docker image  
```
$ docker build -t buildroot-builder .
```

## How to use

The container default working directory is `/home/project`, it is also a mountpoint that can be used to mount your current working directory into the container, like: 
```
 docker run -it --rm \
            -e USER_ID=1000 \
            --mount type=bind,source="$PWD",target="/home/project" \
            buildroot-builder \
            /bin/bash
```

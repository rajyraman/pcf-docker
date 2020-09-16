# Developing PCF Controls Inside Docker

[Dev Containers](https://code.visualstudio.com/docs/remote/containers) do not support Windows containers at the moment. But, both PCF CLI and pcf-scripts npm package, do not work inside Linux containers. Hence you can use this Docker container to develop inside your Visual Studio Code.

## Build

```
docker build --pull --rm -t rajyraman/pcf:v1 -t rajyraman/pcf -t ghcr.io/rajyraman/pcf:v1 -t ghcr.io/rajyraman/pcf .
```

## Run

Below is an example of the command you need to run, if you want to spin up a new container using the pcf image.

```
docker run -it -v $pwd\src:c:\src --name TestComponent -p 8181:8181  --env-file pcf.env  ghcr.io/rajyraman/pcf
```

## Environment File

Below is the sample pcf.env that can be used in your docker run command.

```
namespace=RYR
name=TestComponent
template=field
publishername=natraj
publisherprefix=ryr
```

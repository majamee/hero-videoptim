# auto-caesium
Docker container that uses bardiir/caesium to auto-optimize a full directory of files, ignoring (1:1 copying) non optimizable and failed files

[![](https://images.microbadger.com/badges/version/bardiir/auto-caesium.svg)](https://microbadger.com/images/bardiir/auto-caesium "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/bardiir/auto-caesium.svg)](https://microbadger.com/images/bardiir/auto-caesium "Get your own image badge on microbadger.com") [![GitHub last commit](https://img.shields.io/github/last-commit/bardiir/auto-caesium.svg)](https://github.com/bardiir/auto-caesium) [![Docker Automated build](https://img.shields.io/docker/automated/bardiir/auto-caesium.svg)](https://hub.docker.com/r/bardiir/auto-caesium/builds/) [![Docker Build Status](https://img.shields.io/docker/build/bardiir/auto-caesium.svg)](https://hub.docker.com/r/bardiir/auto-caesium/builds/)

## Usage
```
$ docker run -v /path/to/your/image/files:/caesium bardiir/auto-caesium
```

This will mount the folder `/path/to/your/image/files` into the docker image and convert all files within the folder replacing image files with optimized versions and leaving everything that cannot be optimized without errors as is.
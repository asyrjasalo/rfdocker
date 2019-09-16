# rfdocker

[Robot Framework](http://robotframework.org/) in a [Official Python 3](https://hub.docker.com/_/python?tab=description) and Debian Buster based (slim)
Docker container.

### Why?

1. To run tests in an environment that is well isolated from the host
2. To get started fast when prototyping/developing own Robot Framework libraries
3. To be able to take Robot Framework into use where `sudo` is not available

## Usage

Download `rfdocker` and `Dockerfile` to where your `atest/` are:

    curl https://raw.githubusercontent.com/asyrjasalo/rfdocker/master/rfdocker -o rfdocker || \
    wget https://raw.githubusercontent.com/asyrjasalo/rfdocker/master/rfdocker -O rfdocker && \
    chmod +x rfdocker && \
    curl https://raw.githubusercontent.com/asyrjasalo/rfdocker/master/Dockerfile -o Dockerfile || \
    wget https://raw.githubusercontent.com/asyrjasalo/rfdocker/master/Dockerfile -O Dockerfile && \
    echo "Done."

 Then:

    ./rfdocker

The Robot Framework output files are put in the same directory under `results/`.

### Robot Framework arguments

Any arguments are forwarded to `robot` inside the container, e.g. the output directory can be renamed with:

    ./rfdocker --outputdir results/$(date +%Y-%m-%dT%H:%M:%S) atest/

### External Robot Framework libraries

Put the external libraries to `requirements.txt` and uncomment the lines in `Dockerfile`. The packages are automatically installed inside the container whenever `rfdocker` is ran.

### Customizing `docker` arguments

You can pass variable `BUILD_ARGS` to `rfdocker` to customize `docker build` arguments, and variable `BUILD_DIR` to override the path of the directory where `Dockerfile` and `requirements.txt` are.

Similarly, you can pass variable `RUN_ARGS` to `rfdocker` to e.g. define additional `docker run` arguments, e.g. to change the default volume mappings
or networking.

## Building and hosting your own images

The rfdocker images are hosted in [Docker Hub, robotframework/rfdocker](https://hub.docker.com/r/robotframework/rfdocker). The version numbers correspond to the Robot Framework releases.

**Since Robot Framework version 3.0.4, [Python 2 image is unmaintained](https://pythonclock.org).**

The images are built with `docker/Dockerfile.slimbuster`. The image is smoke tested using `rfdocker` in the repo itself.

Robot Framework version is read from file `docker/rf_version`, and Python version from file `docker/python_version`.

To build a new base image:

    docker/build_and_test_image

To push the image to your private Docker registry (which you should always do):

    REGISTRY_URL=https://your.private.registry/username \
      docker/tag_and_push_image

For pushing to public [Docker Hub](https://hub.docker.com), you may want to use:

    REGISTRY_URL=username \
      docker/tag_and_push_image

Remember to `docker login` for the script to push to a Docker registry.

## Contributing to this repo

Run [shellcheck](https://github.com/koalaman/shellcheck) for changes in scripts:

    shellcheck rfdocker docker/build_and_test_image docker/tag_and_push_image

I could appreciate some help to have something similar working on Windows.

# rfdocker

[Robot Framework](http://robotframework.org/) in a lightweight [Alpine Linux](https://alpinelinux.org/) based Docker container.

### Why?

1. To take Robot Framework into use without (having `sudo` to do) installations on the host
2. To avoid virtualenvs, etc. to deal with conflicting library dependencies
3. To be able to install Robot Framework and run tests or tasks with one command

## Usage

Download `rfdocker` and `Dockerfile` to where your `robots/` are:

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

    ./rfdocker --outputdir results/$(date +%Y-%m-%dT%H:%M:%S) robots/

### External Robot Framework libraries

Put the external libraries to `requirements.txt` and uncomment the lines in `Dockerfile`. The packages are automatically installed inside the container whenever `rfdocker` is ran.

If the external libraries require OS-level dependencies, you may need to add installation of these to `Dockerfile` (before running `pip`).

On Alpine Linux, you can install packages with `RUN apk add --update {{packagename}}`. See [Alpine Linux wiki page](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management) for more information, and `docker/Dockerfile.base` in this repository as an example.

### Customizing `docker` arguments

You can pass variable `BUILD_ARGS` to `rfdocker` to customize `docker build` arguments, and variable `BUILD_DIR` to override the path of the directory where `Dockerfile` and `requirements.txt` are.

Similarly, you can pass variable `RUN_ARGS` to `rfdocker` to e.g. define additional `docker run` arguments, e.g. to change the default volume mappings
or networking.

## Contributing

Git branches 'master' and 'python2' are to build images for Robot Framework on Python 3 and 2 series, respectively. The both images are hosted in [Docker Hub, robotframework/rfdocker](https://hub.docker.com/r/robotframework/rfdocker). The version numbers correspond to the Robot Framework releases.

**Since Robot Framework version 3.0.4, [Python 2 image is unmaintained](https://pythonclock.org).**

In addition to version numbered tags, tag 'latest' references to the latest Robot Framework final (no rcs) on Python 3 series - please use tag 'latest' carefully though, in general with Docker images, as it is possible that the upcoming Robot Framework versions could introduce some backwards incompatible changes in the future, without you noticing this as easily as when using explicit version numbers.

The images are built using `rfdocker` itself, with the help of `scripts/`. You may benefit from these scripts for distributing your own images as well.

To build a new image:

    scripts/build

The Robot Framework version is read from file `scripts/release_name`, and Python version from file `scripts/python_version`.

To push the image to Docker registry (and create a git tag after `release_name`):

    scripts/release https://your.private.registry.com:5000/rfdocker

For pushing to [Docker Hub](https://hub.docker.com), you can use:

    scripts/release {{organization}}/rfdocker

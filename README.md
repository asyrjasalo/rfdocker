# rfdocker

[Robot Framework](http://robotframework.org/) in a lightweight [Alpine Linux](https://alpinelinux.org/) based Docker container.

### Why?

1. To take Robot Framework into use without (having `sudo` to do) installations on the host
2. To avoid virtualenvs, etc. to deal with conflicting dependencies of the test libraries
3. To be able to install Robot Framework and run the tests with one command

## Usage

Download `rfdocker` and `Dockerfile` to where your `tests/` directory is:

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

    ./rfdocker --outputdir results/$(date +%Y-%m-%dT%H:%M:%S) tests/

### External test libraries

Put the external test libraries to `requirements.txt` and uncomment the lines in `Dockerfile`. The packages are automatically installed inside the container whenever `rfdocker` is ran.

If the external test libraries require OS-level dependencies, you may need to add installation of these to `Dockerfile` (before running `pip`).

On Alpine Linux, you can install packages with `RUN apk add --update <packagename>`. See [Alpine Linux wiki page](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management) for more information, and `docker/Dockerfile.base` in this repository as an example.

### Customizing `docker` arguments

You can pass variable `BUILD_ARGS` to `rfdocker` to customize how `docker build` is ran, and variable `BUILD_DIR` to override the path of `Dockerfile` and `requirements.txt`.

Similarly, you can pass variable `RUN_ARGS` to `rfdocker` to e.g. define additional volume mappings for CI, to persist `results/` outside the Jenkins job's workspace, or to allow connecting to your host machine from the container (`RUN_ARGS="--network=host"`).

## Contributing

Git branches 'master' and 'python2' are to build images for Robot Framework on Python 3 and 2 series, respectively. The both images are hosted in [Docker Hub, robotframework/rfdocker](https://hub.docker.com/r/robotframework/rfdocker). The version numbers correspond to the Robot Framework releases. The images are built using `rfdocker` itself, with the help of `scripts/`. You may benefit from these scripts for distributing your own images as well.

To build a new image:

    scripts/build

The Robot Framework version is read from file `scripts/release_name`, and Python version from file `scripts/python_version`.

To push the image to Docker registry and create a git tag named after `release_name`:

    scripts/release REPOSITORY_URL

For example:

    scripts/release https://your.private.registry.com:5000/rfdocker

For pushing to [Docker Hub](https://hub.docker.com), you can use:

    scripts/release YOURORGANIZATION/rfdocker

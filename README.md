# rfdocker

[Robot Framework](http://robotframework.org/) in a lightweight [Alpine Linux](https://alpinelinux.org/) based Docker container.

### Why?

1. To try out Robot Framework, or take it into use, without (having access to do) any  installations on the host
2. To avoid managing virtualenvs to deal with conflicting Python dependencies of the test libraries
3. Still be able to run your Robot Framework tests with one command, as a drop-in placement

### Versioning

Git branches 'master' and 'python2' are to build the Docker images for Robot Framework on Python 3 and 2 series, respectively.

The prebuilt images for both are hosted in [Docker Hub](https://hub.docker.com/r/robotframework/rfdocker). The version number in the image tag corresponds to the Robot Framework release.

## Usage

To run `tests/` in the current working directory:

    docker run --rm -ti -e UID=$UID -e GID=$GID \
      -v "$PWD":/home/robot \
      robotframework/rfdocker:3.0.2 tests/

With the above command, the output files are put in the current working directory under `results/`.

### Robot Framework arguments

Any given arguments are passed forward to `robot` in the container, e.g. the output directory can be renamed with:

    docker run --rm -ti -e UID=$UID -e GID=$GID \
      -v "$PWD":/home/robot \
      robotframework/rfdocker:3.0.2 tests/ \
      --outputdir results/ci/$(date +%Y-%m-%dT%H:%M:%S)

## External test libraries

You can base on top of `robotframework/rfdocker` images for creating your own distributions with the external test libraries bundled in as following.

### 1. Create a `Dockerfile`

```
FROM robotframework/rfdocker:3.0.2
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
```

Put the external test libraries as Python packages into `requirements.txt`, as usually. Here we are assuming `requirements.txt` is in the same directory as `Dockerfile`.

If the test libraries require OS-level dependencies, you can install them before `pip install` with `RUN apk add --update <packagename>`. See [Alpine Linux wiki page](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management) for more information, and `docker/Dockerfile` in this repository for an example of `apk` usage.

### 2. Build your image

Assuming `Dockerfile` is in the current directory (`.`):

    docker build . -t rfdocker:3.0.2-YOURDISTNAME

### 3. Run your tests

    docker run --rm -ti -e UID=$UID -e GID=$GID \
      -v "$PWD":/home/robot \
      rfdocker:3.0.2-YOURDISTNAME tests/

## Contributing

These steps tell how `rfdocker` image itself is built from scratch.

### 1. Build the image

The Robot Framework version is read from `release_name` file.
The Python version is read from `python_version` file.

    scripts/build.sh

### 2. Run a test as a sanity check for the built image

    scripts/test.sh

### 3. Push the image to a Docker registry, and create a git tag for the release

    scripts/release.sh REPOSITORY_URL

For example:

    scripts/release.sh https://your.private.registry.com:5000/rfdocker

If pushing to [Docker Hub](https://hub.docker.com), you can use:

    scripts/release.sh yourorganization/rfdocker

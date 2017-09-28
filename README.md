# rfdocker

https://hub.docker.com/r/robotframework/rfdocker

Robot Framework running in an Alpine Linux based Docker container.

Regarding the installed Python packages: In addition to 'robotframework', the container has 'robotframework-debuglibrary' installed.

## Usage

    export RESULTS_PATH="$(pwd)/results"
    export TESTS_PATH="$(pwd)/tests"
    docker run --rm -ti \
      -e UNAME="robot" \
      -e GNAME="robot" \
      -e UID=$(id -u) \
      -e GID=$(id -g) \
      -v "$RESULTS_PATH":/home/robot/results \
      -v "$TESTS_PATH":/home/robot/tests \
      robotframework/rfdocker:3.0.2 tests

## Development

### Build the image

The Robot Framework version to build is read from `release_name` file.

    scripts/build.sh

### Run sanity checks for the built image

    scripts/test.sh

### Push image to Docker registry

    scripts/release.sh REPOSITORY_URL

For example:

    scripts/release.sh https://your.registry.com:5000/rfdocker

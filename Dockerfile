# https://github.com/asyrjasalo/rfdocker
# https://hub.docker.com/r/robotframework/rfdocker

ARG FROM_IMAGE=robotframework/rfdocker
FROM $FROM_IMAGE:3.1.2

### Uncomment following two lines if having external test libraries:
#COPY --chown=robot:robot requirements.txt .
#RUN pip3 install --no-cache-dir -r requirements.txt

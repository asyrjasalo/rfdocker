# https://github.com/asyrjasalo/rfdocker
# https://hub.docker.com/r/robotframework/rfdocker

ARG FROM_IMAGE=robotframework/rfdocker:3.1.2-slimbuster
FROM $FROM_IMAGE

### Uncomment following two lines if having external test libraries:
#COPY --chown=robot:robot requirements.txt .
#RUN pip3 install --no-cache-dir -r requirements.txt

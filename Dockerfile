# define built-time variable
ARG PARENT_VERSION=latest

# add some metadata to the image
LABEL vendor="ACME Corporation"

# inherit from base image
FROM parentimage:latest

# indicate a port on which the container listens to sommunications
EXPOSE 8080

# set an environment variable
ENV JAVA_HOME /my/dir
ENV PATH $JAVA_HOME:$PATH

# define the user (and group) for all subsequent RUN, CMD and ENTRYPOINT commands
USER myuser:mygroup

# define the working directory for RUN, CMD, ENTRYPOINT, COPY and ADD commands
WORKDIR /myworkdir

# run some shell command as part of the build (you can use ENV vars here)
RUN apt-get update && apt-get install curl

# add some files from the build-host to the image (can also add --chown=username)
COPY /buildhostdir/*.jpg /imagedir/subdir/

# unpack a TAR on the build-host to the image (can also add --chown=username)
ADD /buildhostdir/sometar.tar /imagedir/subdir/

# create a mount-point (unmounted) in the image, to which you have to mount a host-dir or docker-volume upon runtime
VOLUME /mymountpoint

# when using the container as executable (with custom params), entrypoint defines the prefix of the executed commandline
ENTRYPOINT ["java", "-Xmx1g"]

# the run-command to be called when launching the container
CMD ["-jar", "myapp.war"]

# add a periodic healthcheck
HEALTHCHECK --start-period=10s --interval=5m --timeout=3s --retries=3 CMD curl -f http://localhost/ || exit 1
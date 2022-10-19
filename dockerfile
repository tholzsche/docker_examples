FROM ubuntu:bionic

ENV UNAME noob

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --yes \
 x11vnc xvfb firefox


# Set up the user
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    mkdir -p "/home/${UNAME}/.vnc" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

USER ${UNAME}
ENV HOME /home/${UNAME}


# We generate the password for VNC during image build time, which would 
# normally be poor practice, however this makes it easier to keep
# If the container will be used locally and there are no other users or
# services that could access it, this line can be omitted
RUN bash -c 'PASSWD=$(head -c 20 /dev/urandom | base64); echo "VNC Password: $PASSWD"; x11vnc -storepasswd $PASSWD /home/'${UNAME}'/.vnc/passwd'


# Set so that when xterm launches on login, it will launch Firefox
RUN bash -c 'echo "firefox" >> /home/'${UNAME}'/.bashrc'

FROM ubuntu:16.04

ENV UNAME noob

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --yes \
 libncurses5-dev libncursesw5-dev libncurses5 libtinfo5 libtinfo-dev \
 libstdc++6 \
 libgtk2.0-0 \
 dpkg-dev \
 lib32stdc++6 \
 libgtk2.0-0 \
 libfontconfig1 \
 libx11-6 \
 libxext6 \
 libxrender1 \
 libsm6 \
 libqtgui4 \
 libxi6 \
 openjdk-8-jdk

# Set up the user
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

#COPY Xilinx_Vivado_SDK_Lin_2014.1_0405_1 /home/${UNAME}


USER ${UNAME}
ENV HOME /home/${UNAME}

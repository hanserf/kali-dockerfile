FROM kalilinux/kali-rolling

LABEL \
    kali.version=rolling

ENV DEBIAN_FRONTEND noninteractive

RUN set -x &&\
    apt-get update && \
    apt-get install -y --quiet \
    kali-linux-headless 

RUN \
    echo "en_US.UTF-8 UTF-8" >/etc/locale.gen && \
    locale-gen && \
    update-locale \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

ENV MY_REPOPATH="/tmp/develop"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE en_US
ARG UID=1000
ARG GUID=1000
ARG USERNAME=worker

RUN \
    groupadd "${USERNAME}" --gid "${GUID}" &&\
    useradd "${USERNAME}" --uid "${UID}" --gid "${GUID}" \
    --create-home \
    --no-user-group \
    --groups sudo,dialout \
    --password ""

# Add a temporary Volume
VOLUME ["${MY_REPOPATH}"]

WORKDIR "${MY_REPOPATH}"

EXPOSE  9170

CMD ["/bin/bash"]
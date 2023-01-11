# This is an updated version of work done by Jeff Geerling
# https://github.com/geerlingguy/docker-ubuntu2004-ansible
FROM ubuntu:jammy-20221130

LABEL maintainer="Rod Anami <rod.anami@kyndryl.com>"

ENV container "docker"
ENV pip_packages "ansible"

ARG DEBIAN_FRONTEND=noninteractive

# Enable systemd on Ubuntu
RUN apt-get update ; \
    apt-get install -y --no-install-recommends systemd systemd-sysv systemd-cron \
    apt-utils \
    build-essential \
    locales \
    libffi-dev \
    libssl-dev \
    libyaml-dev \
    python3-dev \
    python3-setuptools \
    python3-pip \
    python3-yaml \
    software-properties-common \
    sudo iproute2 ; \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ; \
    rm -Rf /usr/share/doc ; \
    rm -Rf /usr/share/man ; \
    cd /lib/systemd/system/sysinit.target.wants/ ; \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 ; \
    rm -f /lib/systemd/system/multi-user.target.wants/* ; \
    rm -f /etc/systemd/system/*.wants/* ; \
    rm -f /lib/systemd/system/local-fs.target.wants/* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -f /lib/systemd/system/basic.target.wants/* ; \
    rm -f /lib/systemd/system/anaconda.target.wants/* ; \
    rm -f /lib/systemd/system/plymouth* ; \
    rm -f /lib/systemd/system/systemd-update-utmp* ; \
    rm -f /lib/systemd/system/getty.target ;\
    rm -f /lib/systemd/system/systemd*udev*

# Fix potential UTF-8 errors with ansible-test.
RUN locale-gen en_US.UTF-8

# Install Ansible via Pip.
RUN pip3 install $pip_packages

COPY initctl_wrapper.sh .
RUN chmod +x initctl_wrapper.sh && rm -fr /sbin/initctl && ln -s /initctl_wrapper.sh /sbin/initctl

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

CMD ["/lib/systemd/systemd"]

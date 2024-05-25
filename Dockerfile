FROM debian:unstable

RUN echo "deb http://deb.debian.org/debian unstable main" > /etc/apt/sources.list
RUN rm /etc/apt/sources.list.d/debian.sources

RUN apt update
RUN apt -y upgrade

RUN apt install -y pbuilder
RUN apt install -y nano
RUN apt install -y git

RUN mkdir /root/build

COPY setup-pbuilder.sh /bin/setup-pbuilder.sh
COPY hyprwayland-scanner.sh /bin/hyprwayland-scanner.sh

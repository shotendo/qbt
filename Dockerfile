#
FROM debian:jessie

RUN apt-get update ; \
  apt-get -y install xvfb \
    fluxbox \
    xterm \
    thunar \
    vnc4server \
    tightvncserver \
    libswt-gnome-gtk-3-jni \
    qbittorrent \
    xfce4-terminal \
    thunar ; \
  apt-get clean
#COPY VuzeInstaller.tar.bz2 /tmp
RUN mkdir -p /vnc/.local/share/data/qBittorrent
RUN mkdir -p /vnc/.fluxbox
RUN mkdir -p /vnc/.config/qBittorrent 
#RUN tar -xvf /tmp/VuzeInstaller.tar.bz2 -C /
RUN chmod 777 -R /vnc
  
RUN useradd -u 1999 -U -m -d /vnc vnc

COPY entrypoint.sh /vnc/entrypoint.sh

USER vnc

CMD [ "/usr/bin/tightvncserver", "--help" ]

ENTRYPOINT [ "/bin/bash", "/vnc/entrypoint.sh" ]

FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
RUN apt-get update ; \
  apt-get -y install xvfb \
    vnc4server \
    tightvncserver \
	qbittorrent \
	xterm \
    ratpoison ; \
  apt-get clean

  
# Add non-root user
# && adduser -S -D -u 520 -g 520 -s /sbin/nologin qbittorrent \

# Create symbolic links to simplify mounting
RUN mkdir -p /root/.config/qBittorrent
RUN ln -s /root/.config/qBittorrent /config 

  
# ports and volumes
EXPOSE 6881 6881/udp
VOLUME /config 

COPY entrypoint.sh /vnc/entrypoint.sh



CMD [ "/usr/bin/tightvncserver", "--help" ]

ENTRYPOINT [ "/bin/bash", "/vnc/entrypoint.sh" ]

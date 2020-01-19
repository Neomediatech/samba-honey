FROM neomediatech/ubuntu-base:latest

ENV VERSION=1.0.0 \
    SERVICE=smbd-honey

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y --no-install-recommends samba samba-vfs-modules && \
    rm -rf /var/lib/apt/lists* && \
    mkdir -p /shares
    
COPY conf/smb.conf /etc/samba/smb.conf
COPY bin/* /

RUN chmod a+x /entrypoint.sh

VOLUME [ "/shares" ]

ENTRYPOINT [ "/tini", "--", "/entrypoint.sh" ]
CMD [ "smbd", "-F", "-d", "1" ]

HEALTHCHECK --interval=30s --timeout=5s --retries=20 CMD smbcontrol smbd ping

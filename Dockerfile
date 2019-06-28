FROM slasse/steamcmd:1.0.1

MAINTAINER slasse <slasse007@gmail.com>
# forked from wilkesystems/docker-arma3 

ADD arma3.tar.xz /

RUN apt-get update; \
apt-get install -y bzip2 cron curl exim4-daemon-light p7zip rsyslog supervisor unzip wget xz-utils; \
groupadd -g 999 steam; useradd -d /home/steam -g 999 -m -r -u 999 steam; \
mkdir -p -m 770 /usr/games/arma3; chown steam:steam /usr/games/arma3; \
mkdir -p -m 770 /opt/arma3/mods; chown steam:steam /opt/arma3/mods; \
su -s /bin/bash -l steam -c 'steamcmd +quit'; \
rm -rf /root/.steam /var/lib/apt/lists/*;

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

EXPOSE 2301-2305/udp 9001/tcp

WORKDIR /usr/games/arma3

CMD ["supervisor"]

ENTRYPOINT ["docker-entrypoint.sh"]
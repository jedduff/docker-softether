# SoftEther VPN server

FROM debian:9
LABEL maintainer="jedduff@gmail.com" description="Softether beta for armhf architecture"

ENV VERSION v4.28-9669-beta-2018.09.11
WORKDIR /usr/local/vpnserver

RUN apt-get update &&\
        apt-get -y -q install iptables gcc make wget && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/32bit_-_ARM_EABI/softether-vpnserver-${VERSION}-linux-arm_eabi-32bit.tar.gz -O /tmp/softether-vpnserver.tar.gz &&\
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ &&\
        rm /tmp/softether-vpnserver.tar.gz &&\
        make i_read_and_agree_the_license_agreement &&\
        apt-get purge -y -q --auto-remove gcc make wget

ADD runner.sh /usr/local/vpnserver/runner.sh
RUN chmod 755 /usr/local/vpnserver/runner.sh

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp

ENTRYPOINT ["/usr/local/vpnserver/runner.sh"]

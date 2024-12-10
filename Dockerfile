# Base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget build-essential iproute2 curl tinyproxy && \
    apt-get clean

WORKDIR /

RUN wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.41-9782-beta/softether-vpnclient-v4.41-9782-beta-2022.11.17-linux-x64-64bit.tar.gz && \
    tar xzvf softether-vpnclient-v4.41-9782-beta-2022.11.17-linux-x64-64bit.tar.gz && \
    cd vpnclient && \
    make

WORKDIR /vpnclient
RUN chmod +x vpnclient

COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

COPY setup.sh /vpnclient/setup.sh
RUN chmod +x /vpnclient/setup.sh

EXPOSE 3128

CMD ["/vpnclient/setup.sh"]
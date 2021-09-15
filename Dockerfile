FROM centos:7
RUN yum install -y wget \
    && mkdir -p /usr/local/frp \
    && cd /usr/local/frp \
    && wget https://github.com/fatedier/frp/releases/download/v0.37.1/frp_0.37.1_linux_amd64.tar.gz \
    && tar -zxvf frp_0.37.1_linux_amd64.tar.gz \
    && rm -f /usr/local/frp/frp_0.37.1_linux_amd64/frps \
    && rm -f /usr/local/frp/frp_0.37.1_linux_amd64/frps.ini 

WORKDIR /usr/local/frp/frp_0.37.1_linux_amd64

COPY frpc.ini /usr/local/frp/frp_0.37.1_linux_amd64/frpc.ini

CMD [ "sh", "-c", "./frpc -c ./frpc.ini" ]

EXPOSE 7000
EXPOSE 22

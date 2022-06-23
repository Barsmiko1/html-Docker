FROM ubuntu: latest AS BUILD_IMAGE
RUN apt update && apt install wget unzip -y
RUN git clone -b master https://github.com/barsmiko1/html.git
RUN cd 2106_soft_landing && tar -czf soft.tgz * && mv soft.tgz /root/soft.tgz

FROM ubuntu:latest
LABEL "project"="Marketing"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install apache2 git wget -y
COPY --from=BUILD_IMAGE /root/soft.tgz /var/www/html/
RUN cd /var/www/html/ && tar xzf soft.tgz
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html/
EXPOSE 80

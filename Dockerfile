FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update && apt install wget unzip -y && apt install git -y
RUN git clone https://github.com/Barsmiko1/html-Docker.git && cd html-Docker && tar -czf name.tgz * && mv name.tgz /root/name.tgz

FROM ubuntu:latest
LABEL "project"="Marketing"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install apache2 git wget -y
COPY --from=BUILD_IMAGE /root/name.tgz /var/www/html/
RUN cd /var/www/html/ && tar xzf name.tgz
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html/
EXPOSE 80

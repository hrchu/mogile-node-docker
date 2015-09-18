FROM ubuntu:trusty
MAINTAINER Jeffery Utter "jeff.utter@firespring.com"

RUN apt-get update \
  && apt-get install -y cpanminus build-essential libdbd-mysql-perl sysstat \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  mkdir -p /etc/mogilefs \
  && mkdir -p /var/mogdata/dev1

RUN cpanm install --force MogileFS::Server

ADD mogstored.conf /etc/mogilefs/mogstored.conf

RUN adduser mogile --system --disabled-password \
  && chown mogile -R /var/mogdata

EXPOSE 7500

WORKDIR /var/mogdata

CMD ["mogstored", "-c", "/etc/mogilefs/mogstored.conf"]

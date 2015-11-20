FROM ubuntu:vivid
MAINTAINER craig.patten@ersa.edu.au

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_AU.UTF-8
ENV WEB_CONCURRENCY 8

EXPOSE 8000

RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache
RUN echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

RUN adduser --gecos "" --disabled-password --disabled-login ubuntu

RUN apt-get update && apt-get -y install curl python3-dev language-pack-en-base postgresql-client libpq-dev build-essential
RUN apt-get clean

RUN curl -sL https://bootstrap.pypa.io/get-pip.py | python3
RUN pip install --no-cache-dir gunicorn
RUN pip install --no-cache-dir --process-dependency-links https://github.com/eResearchSA/reporting-unified/archive/v0.3.0.tar.gz

COPY run /
CMD ["/run"]

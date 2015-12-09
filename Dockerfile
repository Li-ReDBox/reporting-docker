FROM ubuntu:wily
MAINTAINER craig.patten@ersa.edu.au

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 8000

RUN apt-get update && apt-get -y install curl python3-dev postgresql-client libpq-dev build-essential
RUN apt-get clean

RUN adduser --gecos "" --disabled-password --disabled-login ubuntu

RUN curl -sL https://bootstrap.pypa.io/get-pip.py | python3
RUN pip install --no-cache-dir gunicorn https://github.com/eResearchSA/reporting-unified/archive/v1.0.0.tar.gz

COPY run /
CMD ["/run"]

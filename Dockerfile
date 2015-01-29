FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y postgresql-client-9.3 postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3 postgis postgresql-9.3-postgis-2.1 varnish

ADD docker/* /
RUN mv /pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
RUN bash /setup_postgresql.sh

RUN useradd -m -d /srv/search search

ADD . /srv/search
RUN rm -rf /srv/search/.git
RUN chown -R search: /srv/search


USER search
WORKDIR /srv/search

EXPOSE 6081
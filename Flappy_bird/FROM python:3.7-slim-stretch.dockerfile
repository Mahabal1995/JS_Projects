FROM python:3.7-slim-stretch

MAINTAINER GALE PARTNERS "blr@galepartners.com"

EXPOSE 8000

ENV HOME /root
ENV APP_HOME /application/
ENV NODE_ENV production
ENV C_FORCE_ROOT=true

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential \
        apt-transport-https \
        ca-certificates \
        gnupg \
        curl \
        git \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        openssh-client \
        file \
        libtiff5-dev \
        libjpeg-dev \
        zlib1g-dev \
        libfreetype6-dev \
        liblcms2-dev \
        tcl8.6-dev \
        tk8.6-dev \
        python-tk \
        xmlsec1 \
        libpython3-dev

# Clean up APT and bundler when done.
RUN rm -rf /usr/share/doc \
           /usr/share/man \
           /usr/share/groff \
           /usr/share/info \
           /usr/share/lintian \
           /usr/share/linda \
           /usr/share/locale/ \
           /var/cache/man

# Clean up APT when done.
RUN apt-get clean
RUN apt-get autoclean
RUN apt-get autoremove
RUN rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

RUN mkdir -p $HOME/.ssh
ADD id_rsa $HOME/.ssh/id_rsa
RUN chmod 600 $HOME/.ssh/id_rsa && chmod 700 $HOME/.ssh
RUN ssh-keyscan github.com >> $HOME/.ssh/known_hosts

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME


RUN mkdir $APP_HOME/requirements
ADD ./src/requirements/* $APP_HOME/requirements/

# RUN pip install -r $APP_HOME/requirements/dev.txt
# RUN pip install -r $APP_HOME/requirements/prod.txt
# RUN pip install uwsgi

# RUN rm -rf requirements

RUN rm -rf id_rsa
RUN rm -rf $HOME/.ssh

ADD . $APP_HOME
RUN rm -rf $APP_HOME/id_rsa

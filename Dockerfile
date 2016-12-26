FROM ubuntu
ARG RUBY_VERSION
ENV RUBY_VERSION ${RUBY_VERSION:-2.3.3}

RUN apt-get update

# basics
RUN apt-get install -y nginx openssh-server git-core openssh-client curl
RUN apt-get install -y nano
RUN apt-get install -y build-essential
RUN apt-get install -y openssl libreadline6 libreadline6-dev \
  curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev \
  sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev \
  automake libtool bison subversion pkg-config libpq-dev

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c 'rvm install $RUBY_VERSION'
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN /bin/bash -l -c "bundle install"
ADD . /myapp

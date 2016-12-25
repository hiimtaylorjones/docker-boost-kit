FROM ubuntu
ARG RUBY_VERSION
ENV RUBY_VERSION ${RUBY_VERSION:-v2.3.3}

RUN sudo apt-get update
RUN sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev
  libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev
  libcurl4-openssl-dev python-software-properties libffi-dev nodejs

RUN sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN source ~/.rvm/scripts/rvm

RUN rvm install $RUBY_VERSION
RUN rvm use $RUBY_VERSION --default

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp

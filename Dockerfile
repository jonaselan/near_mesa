FROM ruby:2.6.3

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  build-essential libpq-dev curl apt-utils

RUN mkdir /near_mesa

WORKDIR /near_mesa

COPY Gemfile /near_mesa/Gemfile
COPY Gemfile.lock /near_mesa/Gemfile.lock
RUN bundle install

COPY . /near_mesa

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
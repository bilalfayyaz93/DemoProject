FROM ruby:2.7.0
RUN apt-get update && apt-get install -y build-essential nodejs yarn
RUN mkdir /shopping101
COPY . /shopping101
WORKDIR /shopping101
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

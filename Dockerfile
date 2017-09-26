FROM ruby:2.4.0
RUN apt-get update && apt-get install -y \ 
  nodejs 

# Add DOI Root Certificate so gem install will work
RUN mkdir /usr/local/lib/ruby/site_ruby/2.4.0/rubygems/ssl_certs/doi.gov
COPY DOIRootCA.crt /usr/local/lib/ruby/site_ruby/2.4.0/rubygems/ssl_certs/doi.gov/DOIRootCA.pem
COPY DOIRootCA.crt /usr/local/share/ca-certificates
RUN update-ca-certificates

# we can install rails
RUN gem install rails -v 4.2.6

# Update ruby gems so installs from rubygems.org will work
RUN gem update --system
RUN gem install rubygems-update -v 2.6.7

RUN update_rubygems --no-ri --no-rdoc
# Put the application in place
COPY . /app
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./
EXPOSE 3000
#in order to run in production set the secret_key_base environment variable on the next line
# export secret_key_base=[secret_key_base]
#CMD ["bundle", "exec", "rails", "server", "-e", "production", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
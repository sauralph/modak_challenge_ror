# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ENV=development

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Set the working directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler
RUN bundle install

# Copy the rest of the application code
COPY . .

# Install JavaScript dependencies
RUN yarn install --check-files

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Run the Rails server
CMD ["bash", "-c", "bundle exec rails db:create db:migrate db:seed && bundle exec rails server -b 0.0.0.0"]

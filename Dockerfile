  
FROM ruby:2.6.3-slim

# Install our dependencies
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev curl

# set our path
ENV INSTALL_PATH /app

# creates our directory
RUN mkdir -p $INSTALL_PATH

# set our directory as a main directory
WORKDIR $INSTALL_PATH

# copy our Gemfile to the container
# Copy files to application folder
COPY Gemfile $INSTALL_PATH/Gemfile
COPY Gemfile.lock $INSTALL_PATH/Gemfile.lock

# Copy all project files to application folder inside container
COPY . $INSTALL_PATH
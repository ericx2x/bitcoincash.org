# Build layer
FROM ruby:2.5.1-stretch

RUN mkdir -p /work
WORKDIR work
RUN gem install bundler
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundler install
COPY . .
RUN bundler exec jekyll build

# Hosting Layer
FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /work/_site/ /usr/share/nginx/html/

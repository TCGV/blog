FROM alpine:3.13
# Docker image for Jekyll to build github-pages
#
# docker build -t "jekyll-github-pages" .
# docker run -v "$(pwd):/home/mypage".ToLower() -w /home/mypage -p 4000:4000 jekyll-github-pages bundle exec jekyll serve --host 0.0.0.0
# 

# Install base, Ruby, Headers, Jekyll, Bundler, github-pages Export Path
RUN apk update
RUN apk upgrade
RUN apk add curl wget bash cmake
RUN apk add ruby ruby-bundler ruby-dev ruby-irb ruby-rdoc libatomic readline readline-dev \
libxml2 libxml2-dev libxslt libxslt-dev zlib-dev zlib \
libffi-dev build-base ruby-bigdecimal ruby-webrick git nodejs
RUN export PATH="/root/.rbenv/bin:$PATH"
RUN rm -rf /var/cache/apk/*
# Install Jekyll and required gems
RUN gem install addressable --version=2.6.0
RUN gem install dnsruby --version=1.61.2
RUN gem install nokogiri --version=1.10.8
RUN gem install html-pipeline --version=2.11.1
RUN gem install bundler --version=2.0.2
RUN gem install rubyzip --version=1.2.3
RUN gem install github-pages --version=198
RUN gem install minitest --version=5.14.1
RUN gem install tzinfo --version=1.2.7
RUN gem install ffi --version=1.12.2
RUN gem install faraday --version=1.0.1
RUN gem install octokit --version=4.18.0
RUN gem install rb-inotify --version=0.10.0
RUN gem install unicode-display_width --version=1.7.0
RUN gem install concurrent-ruby --version=1.1.6
RUN gem install execjs --version=2.7.0
RUN gem install ruby-enum --version=0.8.0
RUN gem install http_parser.rb --version=0.6.0
RUN gem install em-websocket --version=0.5.1
RUN gem install ethon --version=0.12.0
RUN gem install multipart-post --version=2.1.1
RUN gem install rb-fsevent --version=0.10.4
RUN gem install jekyll
RUN gem install jekyll-remote-theme --version=0.3.1
RUN gem install jekyll-redirect-from --version=0.16.0
RUN mkdir /home/mypage
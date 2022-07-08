FROM gitpod/workspace-ruby-3.1

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - && \
  sudo apt-get install -y nodejs

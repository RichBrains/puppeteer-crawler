FROM alpine:edge

# Installs latest Chromium (77) package.
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      freetype-dev \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs-current \
      yarn;

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /var/www/app
RUN mkdir -p /var/www/app

COPY entrypoint.sh /var/www/app/entrypoint.sh

# Run everything after as non-privileged user.
ENTRYPOINT /var/www/app/entrypoint.sh

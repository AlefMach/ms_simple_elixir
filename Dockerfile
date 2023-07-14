FROM bitwalker/alpine-elixir:1.13.4 AS build
LABEL maintainer="admin"

ENV TZ America/Sao_Paulo
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apk update \
    && apk add --no-cache \
    tzdata ncurses-libs postgresql-client \
    build-base openssh-client \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk del tzdata

RUN mkdir /root/.ssh

RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

WORKDIR /app

ARG MIX_ENV=prod

RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./
COPY config config

COPY . ./

RUN --mount=type=ssh mix do deps.get, deps.compile

RUN mix do compile --warnings-as-errors, release

# production stage
FROM alpine:3.12 AS production

# install dependencies
RUN apk upgrade --no-cache \
  && apk add --no-cache \
  ncurses-libs curl \
  libgcc libstdc++

# setup timezone
ENV TZ America/Sao_Paulo
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# setup app
WORKDIR /app
ARG MIX_ENV=prod
COPY --from=build /app/_build/$MIX_ENV/rel/simple_ms_blocklist ./

# start application
COPY start.sh ./
CMD ["sh", "./start.sh"]
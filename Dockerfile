FROM convox/golang:1.8.1

ARG POSTGRES_CLIENT_VERSION=9.6
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list \
  && apt-get update \
  && apt-get install -y awscli postgresql-client-${POSTGRES_CLIENT_VERSION}

ARG BUFFALO_VERSION=0.8.2
RUN go get -d github.com/gobuffalo/buffalo \
  && cd ${GOPATH}/src/github.com/gobuffalo/buffalo \
  && git checkout v${BUFFALO_VERSION} \
  && go get github.com/gobuffalo/buffalo/...

WORKDIR /app

CMD ["buffalo", "dev"]

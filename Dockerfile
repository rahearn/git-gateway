FROM golang:1.13

ADD . /go/src/github.com/netlify/git-gateway

ENV GITGATEWAY_JWT_SECRET="CHANGE ME AT RUNTIME"
ENV GITGATEWAY_GITHUB_ACCESS_TOKEN="CHANGE ME AT RUNTIME"
ENV GITGATEWAY_GITHUB_REPO="CHANGE ME AT RUNTIME"

ENV GITGATEWAY_DB_DRIVER=sqlite3
ENV DATABASE_URL=gorm.db
ENV GITGATEWAY_API_HOST=0.0.0.0
ENV PORT=9999
EXPOSE $PORT

# leave blank to allow all roles
ENV GITGATEWAY_ROLES="admin,cms,events"

RUN useradd -m netlify && cd /go/src/github.com/netlify/git-gateway && make deps build && mv git-gateway /usr/local/bin/

USER netlify
CMD ["git-gateway"]

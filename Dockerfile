# Compile app binary
FROM golang:latest as build-env
RUN mkdir $GOPATH/src/app
WORKDIR $GOPATH/src/app
ARG GO_APP_LOCATION
ENV GO111MODULE=on

COPY go.mod .
COPY go.sum .
COPY main.go .

RUN go mod download

RUN go build -o /root/app
# Run app in scratch
#FROM chromedp/headless-shell

#COPY --from=build-env /root/app /
WORKDIR $GOPATH/bin
CMD ["/root/app"]
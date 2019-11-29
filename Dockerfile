FROM golang:latest as build-env
RUN mkdir $GOPATH/src/app
WORKDIR $GOPATH/src/app
ENV GO111MODULE=on
COPY go.mod .
COPY go.sum .
COPY main.go .
RUN go mod download
RUN go build -o /root/app

FROM chromedp/headless-shell
COPY --from=build-env /root/app /
CMD ["/app"]
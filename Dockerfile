FROM golang:latest as build-env
RUN mkdir $GOPATH/src/app
WORKDIR $GOPATH/src/app
ENV GO111MODULE=on
COPY go.mod .
COPY go.sum .
COPY main.go .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /root/app ./*.go

FROM chromedp/headless-shell
COPY --from=build-env /root/app /
RUN mkdir -p /headless-shell/swiftshader/ \
    && cd /headless-shell/swiftshader/ \
    && ln -s ../libEGL.so libEGL.so \
    && ln -s ../libGLESv2.so libGLESv2.so
CMD ["/app"]
FROM progrium/envy

ADD ./data /tmp/data
ADD ./scripts /bin/

COPY ./cmd/envyd.go /go/src/github.com/progrium/envy/cmd/envyd.go
RUN go get && go build -o /bin/envyd

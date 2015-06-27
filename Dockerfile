FROM progrium/envy

ADD ./data /tmp/data
ADD ./scripts /bin/

COPY . /go/src/github.com/progrium/envy
RUN go get && go build -o /bin/envyd

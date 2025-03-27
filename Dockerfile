FROM golang:1.22 AS building
COPY . /building
WORKDIR /building
RUN make frps
RUN make frpc

FROM alpine:3
COPY --from=building /building/bin/frps /usr/bin/frps
COPY --from=building /building/bin/frpc /usr/bin/frpc
COPY --from=building /building/conf/frpc.toml /etc/frpc.toml
COPY --from=building /building/conf/frps.toml /etc/frps.toml
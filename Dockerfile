FROM quay.io/coreos/etcd:v3.5.21 AS etcd-base

FROM busybox:latest

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY --from=etcd-base /usr/local/bin/etcd /usr/local/bin/etcd
COPY --from=etcd-base /usr/local/bin/etcdctl /usr/local/bin/etcdctl
COPY --from=etcd-base /usr/local/bin/etcdutl /usr/local/bin/etcdutl

EXPOSE 2379 2380

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/local/bin/etcd"]
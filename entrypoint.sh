#!/bin/sh
IP=$(hostname -i)

export ETCD_INITIAL_ADVERTISE_PEER_URLS="http://$IP:2380"
export ETCD_INITIAL_CLUSTER="default=http://$IP:2380"
export ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380" 
export ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379" 
export ETCD_ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379" 
export ETCD_INITIAL_CLUSTER_STATE="new" 

exec /usr/local/bin/etcd

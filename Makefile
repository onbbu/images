build:
	docker build -t onbbu/etcd:dev .

run:
	docker run -p 2379:2379 -p 2380:2380 \
	-e ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster" \
	-v /tmp/etcd-data:/etcd-data \
	onbbu/etcd:dev 


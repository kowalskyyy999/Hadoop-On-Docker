# Hadoop-On-Docker

## How to use it
1. Set Hadoop Version in **.env** for looking specific version can seen be [here](https://archive.apache.org/dist/hadoop/common/)
```shell
export HADOOP_VERSION=
```

2. Build hadoop-base image
```shell
make build
```

3. Build hadoop-cluster
```shell
docker compose up -d
```


## Reference
https://github.com/big-data-europe/docker-hadoop
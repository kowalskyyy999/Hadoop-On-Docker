#!/bin/bash

. ./.env

docker network create bigdata

docker build \
	--build-arg HADOOP_VERSION=$HADOOP_VERSION \
	--build-arg SPARK_VERSION=$SPARK_VERSION \
	--build-arg SPARK_HADOOP_VERSION=$SPARK_HADOOP_VERSION \
	-t hadoop:$HADOOP_VERSION ./image/base/

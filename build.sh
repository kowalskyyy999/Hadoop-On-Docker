#!/bin/bash

source ./.env

docker network rm hadoop-network

docker network create hadoop-network

docker build --build-arg HADOOP_VERSION=$HADOOP_VERSION -t hadoop:$HADOOP_VERSION ./image/base/

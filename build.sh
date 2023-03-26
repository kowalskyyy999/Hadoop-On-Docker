#!/bin/bash

. ./.env

docker network create bigdata

docker build --build-arg HADOOP_VERSION=$HADOOP_VERSION -t hadoop:$HADOOP_VERSION ./image/base/

#!/bin/bash

hdfs dfs -mkdir /apps
hdfs dfs -mkdir /apps/tez
hdfs dfs -copyFromLocal ${TEZ_HOME}/share/tez.tar.gz /apps/tez/

schematool -dbType mysql -initSchema 

sleep 2

hiveserver2
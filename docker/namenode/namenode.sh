#!/bin/bash

# su -c "${HADOOP_HOME}/bin/hdfs namenode -format"
$HADOOP_HOME/bin/hdfs namenode -format -force

# sleep 5
# # Start Namenode Server
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode
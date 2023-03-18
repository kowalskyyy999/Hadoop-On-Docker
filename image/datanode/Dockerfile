ARG HADOOP_VERSION

FROM hadoop:${HADOOP_VERSION}

HEALTHCHECK CMD curl -f http://0.0.0.0:9866/ || exit 1

CMD $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR datanode
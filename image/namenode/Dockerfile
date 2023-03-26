ARG HADOOP_VERSION

FROM hadoop:${HADOOP_VERSION}

RUN ${HADOOP_HOME}/bin/hdfs namenode -format -force

HEALTHCHECK CMD curl -f http://namenode:9870/ || exit 1

EXPOSE 9000 9870

CMD ${HADOOP_HOME}/bin/hdfs --config $HADOOP_CONF_DIR namenode
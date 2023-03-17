ARG HADOOP_VERSION

FROM hadoop:${HADOOP_VERSION}

HEALTHCHECK CMD curl -f http://hadoop-network:8088/ || exit 1

EXPOSE 8088

CMD $HADOOP_HOME/bin/yarn resourcemanager
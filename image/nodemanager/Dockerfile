ARG HADOOP_VERSION

FROM hadoop:${HADOOP_VERSION}

HEALTHCHECK CMD curl -f http://0.0.0.0:8042/ || exit 1

EXPOSE 8042

CMD $HADOOP_HOME/bin/yarn nodemanager
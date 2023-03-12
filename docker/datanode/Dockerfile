FROM ubuntu:20.04

ARG HADOOP_VERSION=3.2.4

RUN useradd -ms /bin/bash hdfs

RUN apt-get update && \
    apt-get install -y wget python3.8 software-properties-common

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y openjdk-8-jdk-headless

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

RUN set -x && \
    tar -zxvf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} /usr/local/etc/hadoop-${HADOOP_VERSION} && \
    mkdir /usr/local/etc/hadoop-${HADOOP_VERSION}/data && \
    mkdir /usr/local/etc/hadoop-${HADOOP_VERSION}/data/dataNode && \
    mkdir /usr/local/etc/hadoop-${HADOOP_VERSION}/data/nameNode && \
    mkdir /usr/local/etc/hadoop-${HADOOP_VERSION}/data/nameNodeSecondary && \
    mkdir /usr/local/etc/hadoop-${HADOOP_VERSION}/logs && \
    mkdir /usr/local/etc/hadoop-${HADOOP_VERSION}/tmp && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

ENV HADOOP_HOME=/usr/local/etc/hadoop-$HADOOP_VERSION
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ENV USER=root

ENV HADOOP_CONF_DIR="${HADOOP_HOME}/etc/hadoop"
ENV HADOOP_COMMON_HOME=${HADOOP_HOME}
ENV HADOOP_HDFS_HOME=${HADOOP_HOME}
ENV HADOOP_YARN_HOME=${HADOOP_HOME}
ENV HADOOP_MAPRED_HOME=${HADOOP_HOME}
ENV HADOOP_COMMON_LIB_NATIVE_DIR="${HADOOP_HOME}/lib/native"
ENV HADOOP_OPTS="-Djava.library.path=${HADOOP_HOME}/lib/native"
ENV HADOOP_LOG_DIR=${HADOOP_HOME}/logs
ENV HADOOP_PID_DIR=${HADOOP_HOME}/tmp

RUN export HADOOP_CLASSPATH=$(hadoop classpath)

# # RUN apt-get update && \
# #     apt-get upgrade -y

COPY hadoop/core-site.xml ${HADOOP_HOME}/etc/hadoop/core-site.xml
COPY hadoop/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml
COPY hadoop/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/mapred-site.xml
COPY hadoop/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/yarn-site.xml

ADD datanode.sh /datanode.sh

RUN chmod a+x /datanode.sh

EXPOSE 9000

CMD ["/datanode.sh"]
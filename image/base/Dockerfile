FROM ubuntu:20.04

ARG HADOOP_VERSION

RUN apt-get clean

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl wget software-properties-common

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


ENV HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/client/*.jar:${HADOOP_HOME}/share/hadoop/common/*.jar:${HADOOP_CLASSPATH}/share/hadoop/common/lib/*.jar:${HADOOP_HOME}/share/hadoop/hdfs/*.jar:${HADOOP_HOME}/share/hadoop/hdfs/lib/*.jar:${HADOOP_HOME}/share/hadoop/mapreduce/*.jar:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*.jar:${HADOOP_HOME}/share/hadoop/yarn/*.jar:${HADOOP_HOME}/share/hadoop/yarn/lib/*.jar

COPY hadoop-conf/*.xml ${HADOOP_HOME}/etc/hadoop/

ENV TZ="Asia/Jakarta"

RUN wget https://dlcdn.apache.org/tez/0.10.2/apache-tez-0.10.2-bin.tar.gz

RUN set -x && \
    tar -zxvf apache-tez-0.10.2-bin.tar.gz && \
    mv apache-tez-0.10.2-bin /usr/local/etc/apache-tez-0.10.2-bin && \
    rm apache-tez-0.10.2-bin.tar.gz

ENV TEZ_HOME="/usr/local/etc/apache-tez-0.10.2-bin"
ENV TEZ_CONF_DIR=${TEZ_HOME}/conf
ENV HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$TEZ_CONF_DIR:$TEZ_HOME/*.jar:$TEZ_HOME/lib/*.jar

COPY tez-conf/tez-site.xml ${TEZ_HOME}/conf/tez-site.xml

RUN sysctl -w net.ipv6.conf.all.disable_ipv6=1
RUN sysctl -w net.ipv6.conf.default.disable_ipv6=1
RUN sysctl -w net.ipv6.conf.lo.disable_ipv6=1

CMD source ~/.bashrc

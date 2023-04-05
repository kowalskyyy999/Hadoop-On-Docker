FROM ubuntu:20.04

ARG HADOOP_VERSION

ARG SPARK_VERSION
ARG SPARK_HADOOP_VERSION

ENV TZ="Asia/Jakarta"

RUN apt-get clean

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl wget software-properties-common

RUN apt-get update && \
    apt-get upgrade -y 

RUN apt-get install -y openjdk-8-jdk-headless

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"

# Download Hadoop 
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -O /usr/local/etc/hadoop-${HADOOP_VERSION}.tar.gz

# Download Spark
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz -O /usr/local/etc/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz

WORKDIR /usr/local/etc

########## Start Setup Hadoop ##########
RUN set -x && \
    tar -zxvf hadoop-${HADOOP_VERSION}.tar.gz && \
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
ENV YARN_CONF_DIR="${HADOOP_HOME}/etc/hadoop"
ENV HADOOP_MAPRED_HOME=${HADOOP_HOME}
ENV HADOOP_COMMON_LIB_NATIVE_DIR="${HADOOP_HOME}/lib/native"
ENV HADOOP_OPTS="-Djava.library.path=${HADOOP_HOME}/lib/native"
ENV HADOOP_LOG_DIR=${HADOOP_HOME}/logs
ENV HADOOP_PID_DIR=${HADOOP_HOME}/tmp


ENV HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/client/*.jar:${HADOOP_HOME}/share/hadoop/common/*.jar:${HADOOP_CLASSPATH}/share/hadoop/common/lib/*.jar:${HADOOP_HOME}/share/hadoop/hdfs/*.jar:${HADOOP_HOME}/share/hadoop/hdfs/lib/*.jar:${HADOOP_HOME}/share/hadoop/mapreduce/*.jar:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*.jar:${HADOOP_HOME}/share/hadoop/yarn/*.jar:${HADOOP_HOME}/share/hadoop/yarn/lib/*.jar

COPY hadoop-conf/*.xml ${HADOOP_HOME}/etc/hadoop/

########## End Setup Hadoop ##########

########## Start Setup Spark ##########
RUN tar -zxvf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz && \
    mkdir /usr/local/etc/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}/logs && \
    rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz

ENV SPARK_HOME=/usr/local/etc/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}
ENV PATH="$PATH:${SPARK_HOME}/bin:${SPARK_HOME}/sbin"

ENV SPARK_CONF_DIR="${SPARK_HOME}/conf"
ENV SPARK_LOG_DIR="${SPARK_HOME}/logs"
ENV SPARK_PID_DIR="${SPARK_HOME}/tmp"
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV SPARK_MASTER_PORT=7077

COPY spark-conf/spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf
COPY spark-conf/*.xml ${SPARK_HOME}/conf/

RUN cp ${SPARK_HOME}/yarn/spark-3.2.2-yarn-shuffle.jar $HADOOP_HOME/share/hadoop/yarn/spark-3.2.2-yarn-shuffle.jar 

RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j_8.0.32-1ubuntu20.04_all.deb

RUN dpkg -i mysql-connector-j_8.0.32-1ubuntu20.04_all.deb

RUN ln -s /usr/share/java/mysql-connector-j-8.0.32.jar ${SPARK_HOME}/jars/mysql-connector-java.jar
########## End Setup Spark ##########

########## Start Setup Tez ##########
RUN wget https://dlcdn.apache.org/tez/0.10.2/apache-tez-0.10.2-bin.tar.gz

RUN set -x && \
    tar -zxvf apache-tez-0.10.2-bin.tar.gz && \
    rm apache-tez-0.10.2-bin.tar.gz

ENV TEZ_HOME="/usr/local/etc/apache-tez-0.10.2-bin"
ENV TEZ_CONF_DIR=${TEZ_HOME}/conf
ENV HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$TEZ_CONF_DIR:$TEZ_HOME/*.jar:$TEZ_HOME/lib/*.jar

COPY tez-conf/tez-site.xml ${TEZ_HOME}/conf/tez-site.xml
########## End Setup Tez ##########

RUN sysctl -w net.ipv6.conf.all.disable_ipv6=1
RUN sysctl -w net.ipv6.conf.default.disable_ipv6=1
RUN sysctl -w net.ipv6.conf.lo.disable_ipv6=1

CMD source ~/.bashrc

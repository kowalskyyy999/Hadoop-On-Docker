ARG HADOOP_VERSION

FROM hadoop:${HADOOP_VERSION}

RUN wget https://dlcdn.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz

RUN set -x && \
    tar -zxvf apache-hive-3.1.3-bin.tar.gz && \
    mv apache-hive-3.1.3-bin /usr/local/etc/apache-hive-3.1.3-bin && \
    rm apache-hive-3.1.3-bin.tar.gz

ENV HIVE_HOME="/usr/local/etc/apache-hive-3.1.3-bin"
ENV PATH=$PATH:$HIVE_HOME/bin

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install postgresql-client-12 -y

RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j_8.0.32-1ubuntu20.04_all.deb

RUN dpkg -i mysql-connector-j_8.0.32-1ubuntu20.04_all.deb

RUN ln -s /usr/share/java/mysql-connector-j-8.0.32.jar $HIVE_HOME/lib/mysql-connector-java.jar

RUN mkdir -p ${HIVE_HOME}/auxlib
RUN wget https://github.com/delta-io/connectors/releases/download/v0.6.0/delta-hive-assembly_2.12-0.6.0.jar -O ${HIVE_HOME}/auxlib/delta-hive-assembly_2.12-0.6.0.jar

COPY hive-site.xml ${HIVE_HOME}/conf

ENV HIVE_CLASSPATH="${HIVE_HOME}/lib/*.jar"
ENV HIVE_CONF=${HIVE_HOME}/conf
ENV HIVE_AUX_JARS_PATH=${HIVE_HOME}/auxlib

EXPOSE 10000

COPY run.sh /run.sh

RUN chmod a+x /run.sh 

CMD /run.sh
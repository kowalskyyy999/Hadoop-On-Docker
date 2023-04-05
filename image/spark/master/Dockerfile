ARG HADOOP_VERSION

FROM hadoop:${HADOOP_VERSION}

EXPOSE 7077 8080 4040

CMD ${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.master.Master >> ${SPARK_HOME}/logs/spark-master.out
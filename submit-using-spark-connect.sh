#!/usr/bin/env bash

if [ -z "$SPARK_HOME" ]; then
  echo "SPARK_HOME is not set. Please set it to your Spark installation directory."
  exit 1
fi

SPARK_CLUSTER_HOST=$(ipconfig getIfAddr en0)
echo "Using SPARK_CLUSTER_HOST = $SPARK_CLUSTER_HOST"

JAVA_OPTS="--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED"
java $JAVA_OPTS -cp target/spark-scala-example.jar spark.examples.SparkConnectApp


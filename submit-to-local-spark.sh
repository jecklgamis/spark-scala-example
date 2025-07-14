#!/usr/bin/env bash

if [ -z "$SPARK_HOME" ]; then
  echo "SPARK_HOME is not set. Please set it to your Spark installation directory."
  exit 1
fi
$SPARK_HOME/bin/spark-submit \
  --master "local[*]" \
  --class spark.examples.SimpleApp \
  target/spark-scala-example.jar


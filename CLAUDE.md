# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Example Apache Spark 4.1.1 job written in Scala 2.13, built with Maven. Requires Java 21.

## Build Commands

- **Build**: `./mvnw clean package`
- **Test**: `./mvnw test`
- **CI build**: `mvn --batch-mode --update-snapshots verify`

The build produces a shaded (fat) JAR at `target/spark-scala-example.jar` via maven-shade-plugin.

## Running

Requires `SPARK_HOME` pointing to a Spark 4.1.1 installation.

- **Local submit**: `$SPARK_HOME/bin/spark-submit --master "local[*]" --class spark.examples.SimpleApp target/spark-scala-example.jar`
- **Spark Connect**: Start server with `$SPARK_HOME/sbin/start-connect-server.sh`, then run with `java --add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED -cp target/spark-scala-example.jar spark.examples.SparkConnectApp`

## Architecture

All source is in `src/main/scala/spark/examples/`:

- **SimpleApp** — Standard Spark job using `SparkSession.builder.appName(...).getOrCreate`. Entry point for spark-submit.
- **SparkConnectApp** — Spark Connect client using `SparkSession.builder.remote("sc://localhost").getOrCreate`. Runs as a standalone JVM process connecting to a remote Spark Connect server.

Both apps follow the same pattern: create a SparkSession, run a DataFrame operation, then close the session. The shaded JAR's main class is `SparkConnectApp` (configured in pom.xml).

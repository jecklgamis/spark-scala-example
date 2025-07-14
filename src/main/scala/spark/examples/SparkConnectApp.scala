package spark.examples

import org.apache.spark.sql.SparkSession
import org.slf4j.LoggerFactory

class SparkConnectApp {
  private val log = LoggerFactory.getLogger(classOf[SparkConnectApp])

  private def runJob(): Unit = {
    val spark = SparkSession.builder.remote("sc://localhost").getOrCreate
    try {
      val df = spark.range(10)
      log.info("Created data frame with count {}", df.count)
      df.show()
    } finally {
      if (spark != null) {
        spark.close()
      }
    }
  }
}


object SparkConnectApp {
  def main(args: Array[String]): Unit = {
    new SparkConnectApp().runJob();
  }
}
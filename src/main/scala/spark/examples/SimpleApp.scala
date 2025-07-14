package spark.examples


import org.apache.spark.sql.SparkSession
import org.slf4j.LoggerFactory

class SimpleApp {
  private val log = LoggerFactory.getLogger(classOf[SimpleApp])

  private def runJob(): Unit = {
    val spark = SparkSession.builder.appName("SimpleApp").getOrCreate
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


object SimpleApp {
  def main(args: Array[String]): Unit = {
    new SimpleApp().runJob();
  }
}
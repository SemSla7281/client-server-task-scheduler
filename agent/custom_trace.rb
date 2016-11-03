#
# Custom backtrace
#
# @author [nityamvakil]
#
class CustomTrace
  def self.log_trace(e)
    trace = e.backtrace[0..15].map { |t| t }

    LOGGER.info "\n" \
    "============== EXCEPTION ============== \n" \
    "time: #{Time.now} \n" \
    "exception: #{e.class} \n" \
    "message: #{e.message} \n" \
    "-------------- backtrace --------------  \n" \
    "#{trace.join("\n")} \n" \
    "=======================================  \n"
  end
end

require 'active_record/log_subscriber'
require 'query_tracer/tracer'

module QueryTracer

  class Logger < ActiveSupport::LogSubscriber
    # event.payload[:name]
    # event.duration
    # event.payload[:sql]
    def sql(event)
      return unless QueryTracer.config.enabled
      
      sql = event.payload[:sql]
      # Skip noisy queries
      trace = Tracer.build_trace(sql)
      return if trace.blank?
      # We're done
      if QueryTracer.config.colorize
        message = "\e[34m\e[43m^^^^ Called from:\e[0m "
        indent = "\e[34m\e[43m->\e[0m "
      else
        message = '^^^^ Called from: '
        indent = " "
      end
      logger.send QueryTracer.config.log_level.to_sym, message + trace.join("\n#{indent}")
    end
  end
end



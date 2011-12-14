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
      unless trace.blank?
        message = color("^^^^ Called from: ", YELLOW, true)
        indent  = color("-> ", YELLOW, true)

        send QueryTracer.config.log_level, message + trace.join("\n#{indent}")
      end
    end
  end
end



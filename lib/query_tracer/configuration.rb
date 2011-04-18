module QueryTracer
  class Configuration
    
    class << self
      
      attr_accessor :show_revision, :enabled, :colorize
      attr_accessor :multiline, :log_level
    
      def set
        db_adapter = ActiveRecord::Base.connection.adapter_name.capitalize
        begin
          QueryTracer::Tracer::EXCLUDE_SQL << QueryTracer::Db.const_get(db_adapter)::SKIP_QUERIES
          QueryTracer::Tracer::EXCLUDE_SQL.flatten!
        rescue
        end
        
        yield self
      end
      
      def log_level
        @log_level || :debug
      end
      
      def skip_queries=(val)
        QueryTracer::Tracer::EXCLUDE_SQL << val
        QueryTracer::Tracer::EXCLUDE_SQL.flatten!
      end
      
    end
      
  end
end
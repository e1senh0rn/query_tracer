require 'query_tracer/tracer/revision'

module QueryTracer
  module Tracer
    extend self
    
    def build_trace(sql)
      unless skip_query?(sql)
        # Skip noisy codepoints
        lines = caller.inject([]) do |filtered, line|
          unless line =~ QueryTracer.config.exclude_codepoint
            filtered << line unless QueryTracer.config.include_codepoints.select{ |expr| line =~ expr }.blank?
          end
          filtered
        end
        
        unless lines.blank?
          lines = lines.first unless QueryTracer.config.multiline
          [QueryTracer::Tracer::Revision.current, lines].flatten
        end
        
      end
    end

    def skip_query?(sql)
      !QueryTracer.config.exclude_sql.select { |expr| sql =~ expr }.blank?
    end

  end
end
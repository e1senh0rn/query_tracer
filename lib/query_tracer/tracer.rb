require 'query_tracer/tracer/revision'

module QueryTracer
  module Tracer
    extend self
    
    def build_trace(sql)
      return nil if skip_query?(sql)

      # Include only selected code points
      lines = []
      if QueryTracer.config.multiline
        caller.each {|line| lines << line if include_line?(line)}
      else
        lines << caller.find {|line| include_line?(line)}
      end
      
      unless lines.blank?
        rev = QueryTracer::Tracer::Revision.current
        lines << rev unless rev.blank?
      end
      
      lines
    end

    def skip_query?(sql)
      !QueryTracer.config.exclude_sql.select { |expr| sql =~ expr }.blank?
    end
    
    def include_line?(line)
      !QueryTracer.config.include_codepoints.select{ |expr| line =~ expr }.blank?
    end

  end
end
require 'query_tracer/configuration'
require 'query_tracer/tracer/revision'

module QueryTracer
  module Tracer
    extend self
    
    INCLUDE_CODEPOINTS = [
      %r{^#{Rails.root}/(app/presenters/.*)},
      %r{^#{Rails.root}/(app/views/.*)},
      %r{^#{Rails.root}/(app/controllers/.*)},
      %r{^#{Rails.root}/(app/models/.*)},
      %r{^#{Rails.root}/(lib/.*)},
      %r{^#{Rails.root}/(spec/.*)},
      %r{^#{Rails.root}/(app/.*)},
      %r{^#{Rails.root}/(vendor/(?:gems|plugins)/.*)},
      %r{^#{Rails.root}/(.*)},
      %r{in `(irb)_binding'}
    ]
    # A regular expression used to skip certain code points (gems that do nothing
    # but add noice to the result).
    EXCLUDE_CODEPOINT = %r{^(#{Rails.root}/(?:vendor/(?:rails|gems/(?:composite_primary_keys|db-charmer)|plugins/(?:paginating_find|acts_as_sluggable))|config/initializers/mysql_adapter_extensions\.rb|tmp/gems|lib/query_tracer))|\.rvm/rubies}
    # A regular expression to exclude certain SQL queries from processing (who cares
    # where SHOW TABLES was issues from).
    EXCLUDE_SQL = []

    def build_trace(sql)
      unless skip_query?(sql)
        # Skip noisy codepoints
        lines = caller.inject([]) do |filtered, line|
          unless line =~ EXCLUDE_CODEPOINT
            filtered << line unless INCLUDE_CODEPOINTS.select{ |expr| line =~ expr }.blank?
          end
          filtered
        end
        
        unless lines.blank?
          lines = lines.first unless QueryTracer::Configuration.multiline
          [QueryTracer::Tracer::Revision.current, lines].flatten
        end
        
      end
    end

    def skip_query?(sql)
      !EXCLUDE_SQL.select { |expr| sql =~ expr }.blank?
    end

  end
end
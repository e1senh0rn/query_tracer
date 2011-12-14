require 'ostruct'
require 'active_support'
require 'active_record'
require 'query_tracer/tracer'
require 'query_tracer/logger'
require 'query_tracer/db'

module QueryTracer
  
  def self.configure
    @config = OpenStruct.new({
      :enabled       => true,
      :show_revision => true,
      :multiline     => true,
      :exclude_sql   => [],
      :log_level     => :debug
    })
    
    @config.default_codepoints = [
      '(app/presenters/.*)',
      '(app/views/.*)',
      '(app/controllers/.*)',
      '(app/models/.*)',
      '(lib/.*)',
      '(spec/.*)',
      '(app/.*)'
    ]
    @config.db_adapter = ActiveRecord::Base.connection.adapter_name.capitalize
    
    begin
      @config.exclude_sql << QueryTracer::Db.const_get(@config.db_adapter)::SKIP_QUERIES
      @config.exclude_sql.flatten!
    rescue
    end
    
    yield @config
    
    @config.root ||= ::Rails.root
    
    @config.include_codepoints = build_codepoints
    
    Logger.attach_to :active_record
  end
  
  def self.config
    @config
  end
  
  private
  def self.build_codepoints
    @config.default_codepoints.map do |cp| 
      case cp
      when String
        %r{^#{@config.root}/#{cp}}
      when Regexp
        cp
      else
        nil
      end
    end.compact
  end
    
end
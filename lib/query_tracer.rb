require 'ostruct'
require 'query_tracer/tracer'
require 'query_tracer/logger'
require 'query_tracer/db'

module QueryTracer
  
  def self.configure
    @config = OpenStruct.new({
      :enabled       => true,
      :colorize      => true,
      :show_revision => true,
      :multiline     => true,
      :log_level     => :debug,
      :exclude_sql   => [],
      :root          => Rails.root
    })
    
    @config.include_codepoints = [
      %r{^#{@config.root}/(app/presenters/.*)},
      %r{^#{@config.root}/(app/views/.*)},
      %r{^#{@config.root}/(app/controllers/.*)},
      %r{^#{@config.root}/(app/models/.*)},
      %r{^#{@config.root}/(lib/.*)},
      %r{^#{@config.root}/(spec/.*)},
      %r{^#{@config.root}/(app/.*)},
      %r{^#{@config.root}/(vendor/(?:gems|plugins)/.*)},
      %r{^#{@config.root}/(.*)},
      %r{in `(irb)_binding'}
    ]
    
    @config.exclude_codepoint = %r{^(#{@config.root}/(?:vendor/(?:rails|gems/(?:composite_primary_keys|db-charmer)|plugins/(?:paginating_find|acts_as_sluggable))|config/initializers/mysql_adapter_extensions\.rb|tmp/gems|lib/query_tracer))|\.rvm/|/gems/}
    
    @config.db_adapter = ActiveRecord::Base.connection.adapter_name.capitalize
    
    begin
      @config.exclude_sql << QueryTracer::Db.const_get(@config.db_adapter)::SKIP_QUERIES
      @config.exclude_sql.flatten!
    rescue
    end
    
    yield @config
  end
  
  def self.config
    @config
  end
    
end
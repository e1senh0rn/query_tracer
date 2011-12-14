require "bundler/setup"
require "active_record"
require "active_support/all"
require "query_tracer"
require 'capybara/rspec'
# require 'rspec/rails'

RSpec.configure do |config|
  
end

def initialize_logger(multiline = true, revision = true)
  QueryTracer.configure do |tracer|
    tracer.enabled = true
    tracer.show_revision = multiline
    tracer.multiline = revision
    tracer.root = File.expand_path(File.dirname(__FILE__))
  end
end

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :projects, :force => true do |t|
    t.string :name
  end
end

class Project < ActiveRecord::Base
  # column :name, :string
  has_many :tasks
  accepts_nested_attributes_for :tasks
end

ActiveRecord::Schema.define do
  create_table :tasks, :force => true do |t|
    t.integer :project_id
    t.string :name
  end
end

class Task < ActiveRecord::Base
  # column :project_id, :integer
  # column :name, :string
  belongs_to :project
end

# app = Class.new(Rails::Application)
# app.config.secret_token = "token"
# app.config.session_store :cookie_store, :key => "_myapp_session"
# app.config.active_support.deprecation = :log
# app.config.action_controller.perform_caching = false
# app.initialize!
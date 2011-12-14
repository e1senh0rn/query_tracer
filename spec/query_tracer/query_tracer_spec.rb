require 'spec_helper'

describe QueryTracer do
  
  it "should accept configuration" do
    root = File.expand_path(File.dirname(__FILE__))
    
    QueryTracer.configure do |tracer|
      tracer.enabled = true
      tracer.show_revision = true
      tracer.multiline = true
      tracer.root = root
    end
    
    QueryTracer.config.enabled.should be_true
    QueryTracer.config.root.should == root
  end

  it "should load exclude_sql from db adapter" do
    QueryTracer.config.exclude_sql.should == QueryTracer::Db::Sqlite::SKIP_QUERIES
  end
  
  it "should attach logger to active_record"
  
end
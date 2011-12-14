require 'spec_helper'

describe QueryTracer::Tracer do
  describe "SQLite" do
    it "should skip queries from matching exclude_sql" do
      ActiveRecord::Base.connection.stub(:adapter_name).and_return 'Sqlite'
      initialize_logger
      QueryTracer::Tracer.build_trace("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name").should be_nil
    end
  end

  describe "MySQL" do
    it "should skip queries from matching exclude_sql" do
      ActiveRecord::Base.connection.stub(:adapter_name).and_return 'Mysql'
      initialize_logger
      QueryTracer::Tracer.build_trace("SHOW TABLES").should be_nil
    end
  end

  it "should produce mutliline trace if multiline enabled"
  it "should produce only codepoint if multiline disabled"
  
end
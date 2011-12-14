require 'spec_helper'

describe QueryTracer::Logger do
  it "should log in debug level" do
    initialize_logger
    QueryTracer.config.log_level.should == :debug
  end
  
  it "should use colors if Rails colorize enabled" do
    # ActiveSupport::LogSubscriber.colorize_logging = true
    # initialize_logger
  end
  
  it "should not use colors if Rails colorize disabled" do
    # ActiveSupport::LogSubscriber.colorize_logging = false
    # initialize_logger
  end
  
end
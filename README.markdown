# QueryTracer

* https://github.com/daemon/query_tracer

## DESCRIPTION

QueryTracer is designed to log where from queries to DB were made.

## Origins

Original code was built for Scribd by Dmitry Shteflyuk.

## TODO

Rewrite SQL queries adding small trace as a comment. It will show where long running queries came from.

## Usage

Add following code to config/initializers/query_tracer.rb:

    QueryTracer::Configuration.set do |tracer|
      tracer.enabled = true
      tracer.colorize = true
      tracer.show_revision = true
      tracer.multiline = true
      tracer.skip_queries = [%r{FROM sqlite_master}]
    end

    QueryTracer::Logger.attach_to :active_record
    
`skip_queries` will merge one/many regexps into default expressions list (QueryTracer::Tracer::EXCLUDE_SQL) for current DB.

## Example

Let's say we have model

    class User < ActiveRecord::Base
      scope :active, where(:active => true)
      
      def self.traceme
        active.to_a
      end
    end

Invoking `User.traceme` will produce in logs:

      SQL (0.9ms)   SELECT name
     FROM sqlite_master
     WHERE type = 'table' AND NOT name = 'sqlite_sequence'
    
      User Load (25.8ms)  SELECT "users".* FROM "users" WHERE "users"."active" = 't'
    ^^^^ Called from: Rev[d11816c90c2a38dcd866b115ed2ffa28d7d84e2c]
    -> /Users/dm/Projects/tmp/loggertest/app/models/user.rb:5:in `traceme'
    -> (irb):1:in `irb_binding'

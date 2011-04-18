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
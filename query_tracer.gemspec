# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'query_tracer/version'

Gem::Specification.new do |s|
  s.name              = "query_tracer"
  s.version           = QueryTracer::VERSION
  s.authors           = ["Dmitry Shaposhnik", "Dmytro Shteflyuk"]
  s.email             = ["dmitry@shaposhnik.name", "kpumuk@kpumuk.info"]
  s.homepage          = "http://github.com/daemon/query_tracer"
  s.summary           = "Query tracer and logger for Rails3"
  s.description       = "This library helps to find where in your rails app sql query was run."

  # The list of files to be contained in the gem
  s.files         = `git ls-files`.split("\n")
  
  s.require_path = 'lib'

  s.add_dependency('activesupport', '>= 3.0.0')
  s.add_dependency('activerecord', '>= 3.0.0')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('capybara')
  
end

# coding: UTF-8

Gem::Specification.new do |s|
  s.name              = "query_tracer"
  s.version           = "0.0.3"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Dmitry Shaposhnik", "Dmytro Shteflyuk"]
  s.email             = ["dmitry@shaposhnik.name", "kpumuk@kpumuk.info"]
  s.homepage          = "http://github.com/daemon/query_tracer"
  s.summary           = "Query tracer and logger for Rails3"
  s.description       = ""

  s.required_rubygems_version = ">= 1.3.6"
  
  # If you have runtime dependencies, add them here
  # s.add_runtime_dependency "other", "~> 1.2"
  
  # If you have development dependencies, add them here
  # s.add_development_dependency "another", "= 0.9"

  # The list of files to be contained in the gem
  s.files         = `git ls-files`.split("\n")
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  s.require_path = 'lib'

  # For C extensions
  # s.extensions = "ext/extconf.rb"
end

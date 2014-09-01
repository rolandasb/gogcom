lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gogcom/version'

Gem::Specification.new do |s|
  s.name        = 'gogcom'
  s.version     = GogcomV::VERSION
  s.date        = '2014-09-01'
  s.summary     = 'A Ruby library for querying gog.com website'
  s.description = 'Provides a simple, easy-to-use interface for gog.com website.'
  s.authors     = ['Rolandas Barysas']
  s.email       = ['r.b@riseup.net']
  s.files       = Dir['Rakefile', '{lib,test}/**/*', 'README*', 'LICENSE*']
 
  s.add_dependency 'coveralls', '~> 0.7', '>= 0.7.1'
  s.add_development_dependency 'minitest', '~> 5.4', '>= 5.4.1'
  s.add_development_dependency 'rake', '~> 10.3', '>= 10.3.2'

  s.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.3.1'
  s.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.1'
  
  s.homepage    = 'http://rubygems.org/gems/gogcom'
  s.license     = 'zlib'
end

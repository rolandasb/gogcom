# encoding: utf-8
require './lib/gogcom/version'

Gem::Specification.new do |gem|
  gem.name        = 'gogcom'
  gem.version     = Gogcom::VERSION
  gem.date        = '2014-08-10'
  gem.authors     = ['Rolandas Barysas']
  gem.email       = ['hello@rbrs.io']
  gem.summary     = 'A Ruby library for querying gog.com website'
  gem.description = 'Provides a simple, easy-to-use interface for gog.com website.'
  gem.homepage    = 'http://rubygems.org/gems/gogcom'
  gem.license     = 'zlib'

  gem.add_dependency 'coveralls', '~> 0.8'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'minitest', '~> 5.8'
  gem.add_development_dependency 'simplecov', '~> 0.10'
  gem.add_development_dependency 'vcr', '~> 2.9'
  gem.add_development_dependency 'webmock', '~> 1.21'

  gem.add_runtime_dependency 'json', '~> 1.8'
  gem.add_runtime_dependency 'simple-rss', '~> 1.3'

  gem.files = Dir['Rakefile', '{lib,test}/**/*', 'README*', 'LICENSE*']
end

Gem::Specification.new do |s|
  s.name        = 'gogcom'
  s.version     = '0.0.1'
  s.date        = '2014-08-10'
  s.summary     = 'A Ruby library for querying gog.com website'
  s.description = 'Provides a simple, easy-to-use interface for gog.com website.'
  s.authors     = ['Rolandas Barysas']
  s.email       = ['r.b@riseup.net']
  s.files       = Dir['Rakefile', '{lib,test}/**/*', 'README*', 'LICENSE*']
  s.add_runtime_dependency 'nokogiri', ['= 1.6.3.1']
  s.homepage    = 'http://rubygems.org/gems/gogcom'
  s.license     = 'zlib'
end

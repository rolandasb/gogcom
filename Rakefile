require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push %w(test)
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end

desc "Run tests"
task :default => :test

require File.dirname(__FILE__) + '/lib/jinx/json/version'

# the gem name
GEM = 'jinx-json'
GEM_VERSION = Jinx::JSON::VERSION

WINDOWS = (Config::CONFIG['host_os'] =~ /mingw|win32|cygwin/ ? true : false) rescue false
SUDO = WINDOWS ? '' : 'sudo'

desc "Builds the gem"
task :gem do
  sh "jgem build #{GEM}.gemspec"
end

desc "Installs the gem"
task :install => :gem do
  sh "#{SUDO} jgem install #{GEM}-#{GEM_VERSION}.gem"
end

desc "Runs all tests"
task :test do
  pat = File.dirname(__FILE__) + '/**/test/**/*_test.rb'
  Dir[pat].each { |f| sh "jruby #{f}" }
end

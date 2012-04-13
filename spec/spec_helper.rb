require 'rubygems'
require 'bundler/setup'
Bundler.require(:test, :development)

# Load the Family example.
require Bundler.environment.specs.detect { |s| s.name == 'jinx' }.full_gem_path + '/examples/family/lib/family'

# Add serialization
require 'jinx/json/serializer'

module Family
  include Jinx::JSON::Serializer
end

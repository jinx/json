require 'rubygems'
require 'bundler/setup'
Bundler.require(:test, :development)

# Load the jinx family example.
require Bundler.environment.specs.detect { |s| s.name == 'jinx' }.full_gem_path + '/test/helpers/family'

# Add serialization
require 'jinx/json/serializer'

module Family
  include Jinx::JSON::Serializer
end

require 'date'
require 'java'

class DateTime
  # @param [String] json the JSON to deserialize
  # @return [Date] the deserialized object
  def self.json_create(json)
    parse(json['data'])
  end

  # Adds JSON serialization to Ruby Date.
  #
  # @param args the JSON serialization options
  # @return [String] the serialized date
  def to_json(*args)
    {
      'json_class' => self.class.name,
      'data' => to_s
    }.to_json(*args)
  end
end

class Java::JavaUtil::Date
  # Adds JSON serialization to Java Date.
  # The JSON is deserialized as a Ruby Date.
  #
  # @param args the JSON serialization options
  # @return [String] the serialized date
  def to_json(*args)
    to_ruby_date.to_json(*args)
  end
end
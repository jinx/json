require 'spec/spec_helper'

module Family
  describe Address do
    it 'should serialize an address' do
      addr = Address.new(:street1 => '16 Elm St', :city => 'Peoria', :state => 'IL')
      j = JSON[addr.to_json]
      j.street1.should == addr.street1
      j.city.should == addr.city
      j.state.should == addr.state
    end
  end
  
  describe Household do
    it 'should serialize the address' do
      addr = Address.new(:street1 => '16 Elm St', :city => 'Peoria', :state => 'IL')
      hshd = Household.new(:address => addr)
      j = JSON[hshd.to_json]
      j.address.street1.should == addr.street1
      j.address.city.should == addr.city
      j.address.state.should == addr.state
    end
  end
  
  describe Parent do
    it 'should serialize the children' do
      p = Parent.new(:name => 'Oscar')
      c = Child.new(:name => 'Beauregard', :parents => [p])
      p.children << c
      j = JSON[p.to_json]
      j.children.first.name.should == c.name
    end
  end
  
  describe Child do
    it 'should serialize the parent' do
      hshd = Household.new
      p = Parent.new(:name => 'Oscar', :household => hshd)
      c = Child.new(:name => 'Beauregard', :parents => [p])
      p.children << c
      j = JSON[c.to_json]
      j.parents.first.name.should_not be nil
      j.parents.first.household.should_not be nil
    end
    
    describe 'Date' do
      it 'should serialize a Java date as a Ruby date' do
        date = Java.now
        j = JSON[date.to_json]
        j.should be_within(0.005).of(date.to_ruby_date)
      end
    end
  end
end

require 'spec/spec_helper'

module Family
  describe Address do
    it "should serialize an address" do
      a = Address.new(:street1 => '16 Elm St', :city => 'Peoria', :state => 'IL')
      j = JSON[a.to_json]
      j.street1.should == a.street1
      j.city.should == a.city
      j.state.should == a.state
    end
  end
  
  describe Household do
    it "should serialize the address" do
      a = Address.new(:street1 => '16 Elm St', :city => 'Peoria', :state => 'IL')
      h = Household.new(:address => a)
      j = JSON[h.to_json]
      j.address.street1.should == a.street1
      j.address.city.should == a.city
      j.address.state.should == a.state
    end
  end
  
  describe Parent do
    it "should serialize the children" do
      p = Parent.new(:name => 'Oscar')
      c = Child.new(:name => 'Beauregard', :parents => [p])
      p.children << c
      j = JSON[p.to_json]
      j.children.first.name.should == c.name
    end
  end
  
  describe Child do
    it "should only serialize the owner key" do
      h = Household.new
      p = Parent.new(:name => 'Oscar', :household => h)
      c = Child.new(:name => 'Beauregard', :parents => [p])
      p.children << c
      j = JSON[c.to_json]
      j.parents.first.name.should be nil
      j.parents.first.household.should be nil
    end
  end
end

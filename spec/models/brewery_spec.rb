require 'rails_helper'

RSpec.describe Brewery, type: :model do
  # it "has the name and year set correctly and is saved to database" do
  #   brewery = Brewery.create name:"Schenkerla", year:1674
  #   brewery.name.should == "Schenkerla"
  #   brewery.year.should == 1674
  #   brewery.should be_valid
  # end

  # it "without a name is not valid" do
  #   brewery = Brewery.create year:1674
  #   brewery.should_not be_valid
  # end
  describe "when initialized with name Schenkerla and year 1674" do
    subject{ Brewery.create name: "Schenkerla", year:1674 }
    it { should be_valid }
    its(:name) { should eq("Schenkerla") }
    its(:year) { should eq(1674) }
  end
end

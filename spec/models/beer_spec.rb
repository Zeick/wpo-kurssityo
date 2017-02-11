require 'rails_helper'

RSpec.describe Beer, type: :model do

  describe "" do
    let(:bre) { Brewery.new name:"test", year:2000 }

    it "is saved with a style and a name" do
      beer = Beer.create name:"testbeer", style:"teststyle", brewery:bre
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
    end

    it "is not saved with empty name" do
      beer = Beer.new style:"teststyle", brewery:bre
      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end

    it "is not saved with empty style" do
      beer = Beer.new name:"testname", brewery:bre
      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end
  end
end

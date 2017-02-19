require 'rails_helper'
include Helpers

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username:"Pekka"
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user.valid?).to eq(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }
    let(:brewery) { Brewery.new name:"test", year:2000 }
    let(:beer) { Beer.new name:"testbeer", style:"teststyle" }
      
    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating, user:user, beer:beer)
      user.ratings << FactoryGirl.create(:rating2, user:user, beer:beer)
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"C4", password_confirmation:"C4"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(FactoryGirl.create(:brewery), "helles",user,10)
      expect(user.favorite_beer).to eq(beer)
    end
    
    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(FactoryGirl.create(:brewery), "helles",user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(FactoryGirl.create(:brewery), "helles",user, 25)
      expect(user.favorite_beer).to eq(best)
    end
  end
end

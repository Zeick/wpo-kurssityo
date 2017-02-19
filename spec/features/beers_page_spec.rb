require 'rails_helper'
include Helpers

describe "Beers-webpage" do
    before :each do
        FactoryGirl.create :brewery
        FactoryGirl.create :user
    end


    it "creates a beer with non-empty name" do
        sign_in(username:"Pekka", password:"Foobar1")
        visit new_beer_path
        fill_in('beer_name', with:'Muumi')
        expect{
            click_button "Create Beer"
        }.to change{Beer.count}.by(1)
    end

    it "refuses to create a beer with empty name" do
        sign_in(username:"Pekka", password:"Foobar1")
        visit new_beer_path
        click_button "Create Beer"
        expect(Beer.count).to eq(0)
        expect(page).to have_content 'Name is too short'
    end

    it "shows the amount of beers" do
        user = User.create username:"Pekka", password:"Pikachu25", password_confirmation:"Pikachu25"
        create_beers_with_ratings(FactoryGirl.create(:brewery), "helles",user, 10, 20, 15, 7, 9)
        visit beers_path
        expect(page).to have_content 'Number of beers: 5'
    end
end
require 'rails_helper'

describe "Places" do
    it "if one is returned by the API, it is shown at the page" do
        allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([ Place.new( name:"Oljenkorsi", id: 1 ) ] )
        visit places_path
        fill_in('city', with: 'kumpula')
        click_button "Search"
        expect(page).to have_content "Oljenkorsi"
    end

    it "if multiple are returned by the API, all of them are shown" do
        allow(BeermappingApi).to receive(:places_in).with("Pallet Town").and_return([ Place.new( name:"Professor Oak", id: 1 ), Place.new( name:"Home of Red", id: 2 ), Place.new( name:"Home of Blue", id: 3 ) ] )
        visit places_path
        fill_in('city', with: 'Pallet Town')
        click_button "Search"
        expect(page).to have_content "Professor Oak"
        expect(page).to have_content "Home of Red"
        expect(page).to have_content "Home of Blue"
    end

    it "if no places found, a notice is displayed" do
        allow(BeermappingApi).to receive(:places_in).with("Coruscant").and_return([])
        visit places_path
        fill_in('city', with: 'Coruscant')
        click_button "Search"
        expect(page).to have_content "No locations in Coruscant"
    end
end

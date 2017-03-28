require 'rails_helper'

describe "Beerlist page" do
    before :all do
        self.use_transactional_fixtures = false
        WebMock.disable_net_connect!(allow_localhost:true)
    end
    
    before :each do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.start

        @brewery1 = FactoryGirl.create(:brewery, name:"Koff")
        @brewery2 = FactoryGirl.create(:brewery, name:"Schenkerla")
        @brewery3 = FactoryGirl.create(:brewery, name:"Ayinger")
        @beer1 = FactoryGirl.create(:beer, name:"Nikolai", brewery: @brewery1, style:"Lager")
        @beer2 = FactoryGirl.create(:beer, name:"Fastenbier", brewery:@brewery2, style:"Rauchbier")
        @beer3 = FactoryGirl.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:"Weizen")
    end

    after :each do
        DatabaseCleaner.clean
    end
    after :all do
        self.use_transactional_fixtures = true
    end
    
    it "shows one known beer", js:true do
        visit beerlist_path
        save_and_open_page
        expect(page).to have_content "Nikolai"
    end
end

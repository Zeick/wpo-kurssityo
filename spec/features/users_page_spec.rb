require 'rails_helper'
include Helpers

describe "User" do
    let!(:user) { FactoryGirl.create :user }
    
    describe "who has signed up" do
        it "favorite style is shown at user page" do
          create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user, 7, 9)
          create_beers_with_ratings(FactoryGirl.create(:brewery, name: "Schlenkerla"), "bock", user, 10)
          user2 = FactoryGirl.create(:user, username: "Brian")
          create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user2, 50)
          visit user_path(user.id)
          expect(page).to have_content "Favorite style: bock"  
        end 

        it "favorite brewery is shown at user page" do
          create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user, 7, 9)
          create_beers_with_ratings(FactoryGirl.create(:brewery, name: "Schlenkerla"), "bock", user, 10)
          user2 = FactoryGirl.create(:user, username: "Brian")
          create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user2, 50)
          visit user_path(user.id)
          expect(page).to have_content "Favorite brewery: Schlenkerla"  
        end 

        it "can sign in with right credentials" do
            sign_in(username:"Pekka", password:"Foobar1")
            expect(page).to have_content 'Welcome back!'
            expect(page).to have_content 'Pekka'
        end

        it "is redirected back to sign in -form if wrong credentials given" do
            sign_in(username:"Pekka", password:"wrong")
            expect(current_path).to eq(signin_path)
            expect(page).to have_content 'password mismatch'
        end

        it "has only his or her ratings on his or her user page" do
            user2 = User.create username:"Ash Ketchum", password:"Bulbasaur1", password_confirmation:"Bulbasaur1"
            create_beers_with_ratings(FactoryGirl.create(:brewery), "helles",user, 10, 20, 15, 7, 9)
            create_beers_with_ratings(FactoryGirl.create(:brewery), "helles",user2, 30, 14, 12)
            visit user_path(user)
            expect(page).to have_content 'Has 5 ratings'
            expect(page).to have_content 'anonymous 10'
            expect(page).to have_content 'anonymous 20'
            expect(page).to have_content 'anonymous 15'
            expect(page).to have_content 'anonymous 7'
            expect(page).to have_content 'anonymous 9'
            expect(page).to have_no_content 'anonymous 30'
            expect(page).to have_no_content 'anonymous 14'
            expect(page).to have_no_content 'anonymous 12'
        end
        
        it "when destroys his or her rating, the rating is deleted from system" do
            sign_in(username:"Pekka", password:"Foobar1")
            create_beers_with_ratings(FactoryGirl.create(:brewery, name: "Schlenkerla"), "helles",user, 10, 20, 15, 7, 9)
            visit user_path(user)
            expect(Rating.count).to eq(5)
            # Huom! Navigaatiopalkissa on 9 linkkiä ja Ruby-taulukkojen numerointi alkaa nollasta.
            # Tämä poistaa toisen arvostelun (indeksi 10), ensimmäinen arvostelu on indeksissä 9.
            # Jos navigaatiopalkkiin asetetaan lisää linkkejä, on indeksiä kasvatettava vastaavasti.
            page.all('a')[11].click
            expect(page).to have_content 'anonymous 10'
            expect(page).to have_no_content 'anonymous 20'
            expect(page).to have_content 'anonymous 15'
            expect(page).to have_content 'anonymous 7'
            expect(page).to have_content 'anonymous 9'
            expect(Rating.count).to eq(4)
        end
        
    end

    it "when signed up with good credentials, is added to the system" do
        visit signup_path
        fill_in('user_username', with:'Brian')
        fill_in('user_password', with:'Secret55')
        fill_in('user_password_confirmation', with:'Secret55')
        expect{
            click_button('Create User')
        }.to change{User.count}.by(1)
    end
end
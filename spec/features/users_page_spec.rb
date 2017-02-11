require 'rails_helper'
include Helpers

describe "User" do
    before :each do
        FactoryGirl.create :user
    end
    
    describe "who has signed up" do
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
            user = User.create username:"Ville", password:"Pikachu25", password_confirmation:"Pikachu25"
            user2 = User.create username:"Ash Ketchum", password:"Bulbasaur1", password_confirmation:"Bulbasaur1"
#            sign_in(username:"Ville", password:"Pikachu25")
            create_beers_with_ratings(user, 10, 20, 15, 7, 9)
            create_beers_with_ratings(user2, 30, 14, 12)
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
            user = User.create username:"Ville", password:"Pikachu25", password_confirmation:"Pikachu25"
            sign_in(username:"Ville", password:"Pikachu25")
            create_beers_with_ratings(user, 10, 20, 15, 7, 9)
            visit user_path(user)
            expect(Rating.count).to eq(5)
            # Huom! Navigaatiopalkissa on 9 linkkiä ja Ruby-taulukkojen numerointi alkaa nollasta.
            # Tämä poistaa toisen arvostelun (indeksi 10), ensimmäinen arvostelu on indeksissä 9.
            # Jos navigaatiopalkkiin asetetaan lisää linkkejä, on indeksiä kasvatettava vastaavasti.
            page.all('a')[10].click
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
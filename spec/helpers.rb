module Helpers
    def sign_in(credentials)
        visit signin_path
        fill_in('username', with:credentials[:username])
        fill_in('password', with:credentials[:password])
        click_button('Log in')
    end

    def create_beers_with_ratings(user, *scores)
        scores.each do |score|
            create_beer_with_rating(user,score)
        end
    end

    def create_beer_with_rating(user,score)
        beer = FactoryGirl.create(:beer)
        FactoryGirl.create(:rating, score:score, beer:beer, user:user)
        beer
    end
end
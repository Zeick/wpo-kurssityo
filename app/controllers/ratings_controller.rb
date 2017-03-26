class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_users = User.top 3
    @recent_ratings = Rating.recent
  end
  
  def new
    @rating = Rating.new
    @beers = Beer.all
  end
  
  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if current_user
      @rating[:user_id] = current_user.id
      if @rating.save
        current_user.ratings << @rating
        redirect_to user_path current_user
      else
        @beers = Beer.all
        render :new
      end
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user # Poistetaan vain jos poistaja on sama kuin arvostelija
#    redirect_to :back
    redirect_back(fallback_location: ratings_path)
  end
end

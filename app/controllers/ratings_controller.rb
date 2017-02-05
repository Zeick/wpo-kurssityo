class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end
  def new
    @rating = Rating.new
    @beers = Beer.all
  end
  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating[:user_id] = current_user.id
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user # Poistetaan vain jos poistaja on sama kuin arvostelija
    redirect_to :back
  end
end

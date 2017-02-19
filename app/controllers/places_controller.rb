require 'beermapping_api'

class PlacesController < ApplicationController
    def index
    end

    def show
        @place = BeermappingApi.place_in(params[:id], session[:last_city])
        @coordinates = BeermappingApi.gmap(@place.street + ", " + @place.zip + " " + @place.city)
    end

    def search
        @places = BeermappingApi.places_in(params[:city])
        if @places.empty?
            redirect_to places_path, notice: "No locations in #{params[:city]}"
        else
            @weather = BeermappingApi.weather_in(params[:city])
            @iconUrl = @weather["condition"]["icon"]
            @iconUrl = "http:" + @iconUrl
            session[:last_city] = params[:city]
            render :index
        end
    end
end
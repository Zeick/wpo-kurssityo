class BeermappingApi
    def self.weather_in(city)
        url = "http://api.apixu.com/v1/current.json?key=#{apixu}&q="
        response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
        weather = response.parsed_response["current"]
    end


    def self.place_in(id, last_city)
        last_city = last_city.downcase
        places_in(last_city).select{ |p| p.id == id }.first
    end


    def self.places_in(city)
        city = city.downcase
        Rails.cache.fetch(city) { fetch_places_in(city) }
    end

    def self.gmap(address)
        url = "http://maps.google.com/maps/api/geocode/xml?address="
        response = HTTParty.get "#{url}#{ERB::Util.url_encode(address)}"
        coordinates = response.parsed_response["GeocodeResponse"]["result"]["geometry"]["location"]
    end

    private
    def self.fetch_places_in(city)
        url = "http://beermapping.com/webservice/loccity/#{key}/"
        response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
        places = response.parsed_response["bmp_locations"]["location"]
        return [] if places.is_a?(Hash) and places['id'].nil?
        places = [places] if places.is_a?(Hash)
        places.map do | place |
            Place.new(place)
        end
    end
    
    def self.key
        raise "APIKEY environment variable not defined" if ENV['APIKEY'].nil?
        ENV['APIKEY']
    end

    def self.gkey
        raise "APIg environment variable undefined!" if ENV['APIg'].nil?
        ENV['APIg']
    end

    def self.apixu
        raie "APIXU environment variable undefined!" if ENV['APIXU'].nil?
        ENV['APIXU']
    end
    
end
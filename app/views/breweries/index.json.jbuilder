#json.array! @breweries, partial: 'breweries/brewery', as: :brewery
json.array!(@breweries) do |brewery|
    json.extract! brewery, :id, :name, :year
    json.beercount brewery.beers.count
    json.ratingcount brewery.ratings.count
#    json.url brewery_url(brewery, format: :json)
end
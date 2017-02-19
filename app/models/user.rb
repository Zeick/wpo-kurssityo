class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true,
			     length: { minimum: 3, maximum: 30 }	# Käyttäjätunnuksen on oltava vähintään 3 merkkiä ja yksikäsitteinen
	validates :password, length: { minimum: 4 }
	validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
              message: "should contain at least one number and one capital letter." } 
	has_many :ratings, dependent: :destroy # Käyttäjällä voi olla useita arvosteluja. Arvostelut poistetaan, jos käyttäjä poistetaan
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships

	def favorite_beer
		return nil if ratings.empty? # Palautetaan nil jos ei ole arvosteluja
#		ratings.first.beer # Palautetaan ensimmäiseen arvosteluun liittyvä olut.
#		ratings.sort_by{ |r| r.score }.last.beer # Alemman pitkä muoto
#		ratings.sort_by(&:score).last.beer # Vanha versio alemmasta
		ratings.order(score: :desc).limit(1).first.beer
	end

	def favorite_brewery
    return nil if ratings.empty? 
    
    ratings_of_breweries = ratings.group_by { |r| r.beer.brewery }
    averages_of_breweries = []
    ratings_of_breweries.each do |brewery, ratings|
      averages_of_breweries << {
        brewery: brewery,
        rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end  
    averages_of_breweries.sort_by{ |b| -b[:rating] }.first[:brewery]
  end  

  def favorite_style
    return nil if ratings.empty? 
    
    ratings_of_styles = ratings.group_by { |r| r.beer.style }
    averages_of_styles = []
    ratings_of_styles.each do |style, ratings|
      averages_of_styles << {
        style: style,
        rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end  
    averages_of_styles.sort_by{ |b| -b[:rating] }.first[:style]
  end    
	
def to_s
    return "#{self.username}"
  end

end

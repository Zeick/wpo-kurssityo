class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true,
						 length: { minimum: 3, maximum: 30 }	# Käyttäjätunnuksen on oltava vähintään 3 merkkiä ja yksikäsitteinen
	validates :password, length: { minimum: 4 }
	validates_format_of :password, :with => /[A-Z]+.*[0-9]+|[0-9]+.*[A-Z]+/ # RegEx: On oltava ainakin yksi iso kirjain ja numero
	has_many :ratings, dependent: :destroy # Käyttäjällä voi olla useita arvosteluja. Arvostelut poistetaan, jos käyttäjä poistetaan
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships
end

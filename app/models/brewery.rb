class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :name, length: { minimum: 1 }
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                   less_than_or_equal_to: 2017,
                                   only_integer: true }

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end

  # def average_rating
  #   all_ratings = 0
  #   all_ratings_score = 0
  #   self.beers.each do |beer|
  #     all_ratings += beer.ratings.count
  #     if beer.ratings.empty?
      
  #     else
  #       beer.ratings.each do |rat|
  #         all_ratings_score += rat.score 
  #       end
  #     end
  #   end 
  #   if all_ratings == 0

  #   else # to_f varmistaa että saadaan liukuluku, round(1) pyöristää 1 desimaalin tarkkuuteen
  #         return (all_ratings_score/all_ratings.to_f).round(1)
  #   end
  # end
  
  def restart
    self.year = 2017
    puts "changed year to #{year}"
  end
end

class Beer < ActiveRecord::Base
#  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
     return self.ratings.average(:score)
  end
  
  def to_s
    return "#{self.name}, #{self.brewery.name}"
  end
end

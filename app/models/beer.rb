class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  validates :name, length: { minimum: 1 }
  validates :style, presence: true

  # def average_rating
  #    return self.ratings.average(:score)
  # end

  # Palauta listalta parhaat n kappaletta 
  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n)   
  end
  
  def to_s
    return "#{self.name}, #{self.brewery.name}"
  end

  def average
  	return 0 if ratings.empty?
  	ratings.map { |r| r.score }.sum / ratings.count.to_f
  end
end

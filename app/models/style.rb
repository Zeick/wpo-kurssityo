class Style < ActiveRecord::Base
    has_many :beers
    has_many :ratings, through: :beers
    include RatingAverage

    def to_s
        name
    end

    def self.top(n)
        sorted_by_rating_in_desc_order = Style.all.sort_by{ |r| -(r.average_rating||0)}
        return sorted_by_rating_in_desc_order.take(n)
    end
end

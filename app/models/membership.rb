class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :beer_club
	scope :recent, -> { order(created_at: :desc).limit(5) }
end

class UserProfile < ApplicationRecord
	belongs_to :user
	belongs_to :district, :optional => true
  belongs_to :city, :optional => true
end

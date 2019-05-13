class UserProfile < ApplicationRecord
	belongs_to :user
	belongs_to :district
  belongs_to :city
end

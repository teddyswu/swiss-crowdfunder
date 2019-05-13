class District < ApplicationRecord
	belongs_to :city
	has_many :user_profile, :foreign_key => "district_id"
	has_many :supporters, :foreign_key => "district_id"
	scope :normal_state, -> { where(:enabled => true) }
end

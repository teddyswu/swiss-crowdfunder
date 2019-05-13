class City < ApplicationRecord
	
	has_many :districts, :foreign_key => "city_id"
	has_many :user_profiles, :foreign_key => "city_id"
	has_many :supporters, :foreign_key => "city_id"
	scope :normal_state, -> { where(:enabled => true) } #後台用

end

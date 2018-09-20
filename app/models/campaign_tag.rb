class CampaignTag < ApplicationRecord
	has_many :campaign_tag_ships
  has_many :campaigns, :through => :campaign_tag_ships
end

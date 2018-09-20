class CampaignTagShip < ApplicationRecord
	belongs_to :campaign_tag
	belongs_to :campaign

end

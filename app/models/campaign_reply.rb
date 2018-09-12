class CampaignReply < ApplicationRecord
	belongs_to :campaign
	belongs_to :user

	before_create :set_default_parent

	private

  def set_default_parent
    self.parent_id ||= 0
  end
end

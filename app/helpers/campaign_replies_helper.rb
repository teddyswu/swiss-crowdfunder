module CampaignRepliesHelper

	def render_is_sponsor(sponsor_ids, user_id)
		"<span class='badge badge-outlined badge-primary'>贊助人</span>".html_safe if sponsor_ids.include?(user_id)
	end

	def render_is_proposer(proposer_id, user_id)
		"<span class='badge badge-primary'>提案人</span>".html_safe if proposer_id == user_id
	end
end

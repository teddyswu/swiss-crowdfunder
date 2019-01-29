class RootController < ApplicationController
  before_action :set_campaigns, only: [:index]
  def index
    set_page_description("在地的農村故事群眾募資提案，觀看最新提案，關注提案，一起支持提案鼓勵小農。")
    set_page_image("https://www.ugooz.cc/assets/sk2/img/ui/logo.png")
    set_page_title "友善提案列表"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaigns
      @campaigns_top = Campaign.where(:status => 3).limit(1)
      @campaigns = Campaign.where(:status => 3)
      @campaigns_new = Campaign.where(:status => 3).order("updated_at DESC").limit(4)
    end
end

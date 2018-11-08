class RootController < ApplicationController
  before_action :set_campaigns, only: [:index]
  def index
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaigns
      @campaigns_top = Campaign.where(:status => 3).limit(1)
      @campaigns = Campaign.where(:status => 3)
      @campaigns_new = Campaign.where(:status => 3).order("updated_at DESC").limit(4)
    end
end

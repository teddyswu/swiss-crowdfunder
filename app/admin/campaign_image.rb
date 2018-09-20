ActiveAdmin.register CampaignImage do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :file, :landing_page, :campaign_path

  form do |f|
    inputs do
    	input :file
      input :landing_page
      input :campaign_path
    end
    actions
  end

end

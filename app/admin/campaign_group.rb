ActiveAdmin.register CampaignGroup do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :income

  form do |f|
    inputs do
      input :income
    end
    actions
  end

end

ActiveAdmin.register CampaignTag do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name

  form do |f|
    inputs do
      input :name
    end
    actions
  end

end

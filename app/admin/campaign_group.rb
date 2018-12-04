ActiveAdmin.register CampaignGroup do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :income

  index do
  	selectable_column
  	column :id
  	column :user_id
  	column :income
  	actions
  end

  form do |f|
    inputs do
    	input :user_id
      input :income
    end
    actions
  end

end

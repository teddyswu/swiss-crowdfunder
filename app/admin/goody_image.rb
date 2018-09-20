ActiveAdmin.register GoodyImage do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :file, :cover

  form do |f|
    inputs do
    	input :file
      input :cover
    end
    actions
  end

end

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :role, :label => 'Role', :as => :select, :collection => options_for_select([["管理員", "1"], ["會員", "0"]])
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end

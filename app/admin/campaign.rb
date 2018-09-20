ActiveAdmin.register Campaign do
#
  permit_params :goal, :start_date, :end_date, :title, :youtube_url,
    :description, :claim, :twitter_url, :facebook_url,
    :order_description, :order_success, :email, :image, :active, :status

  # friendly_id resource lookup
  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    protected
    def scoped_collection
      super.unscoped
    end

  end

  index do
    selectable_column
    column :id
    column :title
    column :start_date
    column :end_date
    column :claim
    column :status 
    column :created_at
    column :updated_at
    actions
  end
#

  form do |f|
    inputs do
      input :title
      input :active, label: "顯示 (否則只能夠過連結顯示)"
      input :claim
      input :goal
      input :email
      input :image
      input :start_date
      input :end_date
      input :youtube_url
      input :facebook_url
      input :twitter_url
      input :risk, label: "風險與承諾"
      input :description, label: "提案內容"
      input :order_description, label: "贊助時注意事項"
      input :order_success, label: "贊助後注意事項"
      input :status, :label => '狀態', :as => :select, :collection => options_for_select([["草稿", "1"], ["審核中", "2"], ["審核完成", "3"]])
    end
    actions
  end

end

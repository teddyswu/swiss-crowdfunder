ActiveAdmin.register Campaign do
  permit_params :goal, :start_date, :end_date, :title, :youtube_url,
    :description, :claim, :twitter_url, :headline, :slug, :risk, :is_rate,
    :order_description, :order_success, :email, :image, :active, :status

  # friendly_id resource lookup
  controller do
    def find_resource
      scoped_collection.find(params[:id])
    end

    def update
      super
      a = 0
      params[:campaign][:headline].each do |boo|
        if boo == "true"
          Headline.find_or_create_by(:resource_type => "Campaign", :resource_id => params[:id]) 
          a+=1
        end
      end
      Headline.find_by(:resource_type => "Campaign", :resource_id => params[:id]).destroy if a == 0
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
      input :active, label: "顯示 (否則只能夠通過連結顯示)"
      input :claim
      input :slug
      input :goal
      input :email
      input :image
      input :start_date
      input :end_date
      input :youtube_url
      input :twitter_url
      input :risk, label: "風險與承諾"
      input :description, label: "提案內容"
      input :order_description, label: "贊助時注意事項"
      input :order_success, label: "贊助後注意事項"
      input :is_rate, label: "顯示 (顯示調查結果)"
      input :status, :label => '狀態', :as => :select, :collection => options_for_select([["草稿", "1", :selected =>[1].include?(object.status)], ["審核中", "2", :selected =>[2].include?(object.status)], ["審核完成", "3", :selected =>[3].include?(object.status)]])
      @is_headline = Headline.exists?(:resource_type => "Campaign", :resource_id => params[:id])
      input :headline, label: "是否頭條", :as => :check_boxes, :collection => [["true", true, {:checked => @is_headline }]]
    end
    actions
  end

end

ActiveAdmin.register Order do
#
  permit_params :quantity, :amount, :payment_type, :goody_id, :user_id, :bonus,
                :payment_type, :ecpay_payment_type, :paid, :anonymous, :status

  index do
    selectable_column
    column :amount
    column :quantity
    column :payment_type
    column :paid
    column :goody
    column :supporter
    column :agreement
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :quantity
      row :amount
      row :payment_type
      row :paid
      row :goody
      row :supporter
      row :agreement
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def action_methods
      super - ['new', 'create']
    end

    def update
      order = Order.find(params[:id])
      order.update_attributes(order_params)
      if order.status == 4
        order.paid = false
      end
      order.save(:validate => false)
      render action: :index
    end

    def order_params
      params.require(:order).permit(:goody_id, :amount, :user_id, :bonus, :payment_type, :ecpay_payment_type, :paid, :anonymous, :status)
    end
  end

  form do |f|
    inputs do
      input :goody
      input :amount
      input :user_id
      input :bonus
      input :payment_type
      input :ecpay_payment_type
      input :paid, label: "是否付款"
      input :anonymous, label: "是否匿名"
      input :status, :label => '狀態', :as => :select, :collection => options_for_select([["待結帳", "1", :selected =>[1].include?(object.status)], ["未完成", "2", :selected =>[2].include?(object.status)], ["完成", "3", :selected =>[3].include?(object.status)], ["取消", "4", :selected =>[4].include?(object.status)]])
    end
    actions
  end

end

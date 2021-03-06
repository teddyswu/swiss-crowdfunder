ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
      # span class: "blank_slate" do
        # span I18n.t("active_admin.dashboard_welcome.welcome")
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
    # end

    columns do
      column do
        panel "最近的訂單" do
          table_for Order.order("id desc").limit(10) do
            column("Email") { |order| order.supporter.email }
            column("數量") { |order| order.quantity }
            column("金額")   { |order| order.amount }
          end
        end
      end
      column do
        div do
          br
          text_node %{<iframe src="https://rpm.newrelic.com/public/charts/3qK14CnDWRB"
                              width="500" height="300" scrolling="no" frameborder="no">
                      </iframe>}.html_safe
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content

  controller do
    before_action :check_admin
    def check_admin
      redirect_to root_path if current_user.is_admin != true
    end
  end
end

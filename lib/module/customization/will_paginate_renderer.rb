module WillPaginateRenderer
  class WebPageRenderer < WillPaginate::ActionView::LinkRenderer

    # to_html 為初始呼叫的地方，可以直接覆寫
    def to_html
      #single_page_start_number = 1
      #single_page_end_number = 9
      if total_pages >= 9
        if current_page >= 6 && current_page <= total_pages - 4
          single_page_start_number = current_page - 4
          single_page_end_number = current_page + 4
        elsif current_page < 6
          single_page_start_number = 1
          single_page_end_number = 9
        else
          single_page_start_number = total_pages - 8 # 要保持單頁有9個頁碼
          single_page_end_number = total_pages
        end
      else
        single_page_start_number = 1
        single_page_end_number = total_pages
      end

      html = ""
      html << "<li class=\"page-item\">"
      html << link("<span aria-hidden=\"true\">«</span>".html_safe, 1, :class => "page-link")
      html << "</li>"
      html << "<li class=\"page-item\">"
      html << link("...", current_page - 5, :class => "page-link") if current_page >= 6
      html << "</li>"
      for i in (single_page_start_number..single_page_end_number)
        html << page_number(i)
      end
      html << "<li class=\"page-item\">"
      html << link("<span aria-hidden=\"true\">»</span>".html_safe, total_pages, :class => "page-link")
      html << "</li>"

      html << link("...", current_page + 5, :class => "button") if current_page <= total_pages - 6
      html << ""

      return html.html_safe
    end

    def page_number(page)
      if page == current_page
        return "<li class=\"page-item disabled\"><a class=\"page-link\" href=\"#\">#{page}</a></li>"  
      else
        html = ""
        html << "<li class=\"page-item\">"
        html << link(page, page, :rel => rel_value(page), :class => "page-link")
        html << "</li>"
      # return "<li class=\"page-item disabled\"><a class=\"page-link\" href=\"#\">#{page}</a></li>"
        return html
      end
    end

    # 復寫 url
    # 將 url 的 /mobile 拿掉
    # 不過根本原因：位啥會有 /mobile 還不知道
    # 待移除就網址路徑 /mobile 的取代也可以移除
    def url( page )
      url = super

      url = url.sub( "/mobile", "" ) if url.start_with?( "/mobile")
      return url
    end # url()

    def link(text, target, attributes = {})
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end
      # attributes["data-remote"] = true # 加了這段 will_paginate 才可以使用 ajax 模式
      attributes[:href] = target
      tag(:a, text, attributes)
    end
  end
end
class ErrorsController < ApplicationController
  def not_found
  	set_page_title "找不到頁面"
    respond_to do |format|
      format.html { render status: 404 }
    end
  rescue ActionController::UnknownFormat
    render status: 404, text: "404 not found"
  end
end

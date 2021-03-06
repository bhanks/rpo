class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_url_helper
  layout :layout_by_resource

  def get_url_helper
    @url_helper = Rails.application.routes.url_helpers 
  end

  protected
  def layout_by_resource
    if devise_controller?
      "dashboard"
    end
  end
end

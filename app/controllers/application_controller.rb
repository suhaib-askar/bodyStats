class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Для показа времени загрузки страницы
  before_filter :set_start_time
  def set_start_time
    @start_time = Time.now.to_f
  end
  # Devise
  # def after_sign_in_path_for(resource)
  #   #user_url_path
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   #request.referrer
  # end
end

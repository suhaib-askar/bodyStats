class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Для показа времени загрузки страницы
  before_filter :set_start_time
  def set_start_time
    @start_time = Time.now.to_f
  end
  
end

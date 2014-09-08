class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include CustomExceptions::LocalesException
  #before_action :set_i18n_locale_from_params
  before_action :set_start_time

  protect_from_forgery with: :exception
  #check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
  private

    # Devise
    def after_sign_in_path_for(resource)
      #user_url_path
      session["user_return_to"] || root_path
    end
    
    # def after_sign_out_path_for(resource_or_scope)
    #   #request.referrer
    # end
  protected

    def set_i18n_locale_from_params
      locale = params[:locale] || []
      if locale.length == 2 
        if I18n.available_locales.map(&:to_s).include? (locale)
          I18n.locale = session[:locale] = locale
        else
          #flash.now[:error] = "#{locale} translation not available"
          logger.error flash.now[:notice]
          raise UnknownLocale
        end
      else
        I18n.locale = session[:locale]
        redirect_to "/#{I18n.locale}#{request.path}"
      end
    end

    # def default_url_options      
    #   { locale: I18n.locale }
    # end

    # Для показа времени загрузки страницы (Footnotes gem)
    def set_start_time
      @start_time = Time.now.to_f
    end

end

class SessionsController < ApplicationController
  
  def set_locale
    I18n.locale = params[:set_locale]
    return redirect_to request.referer unless locale
    url = request.referer.split('/')
    url = url.map { |v| v = url[3] == v ? I18n.locale : v }.join('/')
    redirect_to url
  end

end
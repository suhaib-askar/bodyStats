class ErrorsController < ApplicationController
  skip_before_filter :set_i18n_locale_from_params # fix for locale redirect on => /404 
  
  layout 'application'
  
  def show
    @exception = env["action_dispatch.exception"]
    @status_code = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    
    respond_to do |format|
      format.html { render action: @status_code, status: @status_code, layout: !request.xhr? }
      format.xml { render xml: details, root: "error", status: @status_code }
      format.json { render json: {error: details, status: @status_code} }
      
      # format.html { render action: request.path[1..-1], status: @status_code, layout: !request.xhr? }
      # format.json { render json: { status: request.path[1..-1], error: @exception.message }}
    end
  end

protected
 
  def details
    @details ||= {}.tap do |h|
      I18n.with_options scope: [:errors, @status_code, @rescue_response], exception_name: @exception.class.name, exception_message: @exception.message do |i18n|
        h[:name] = i18n.t "#{@exception.class.name.underscore}.title", default: i18n.t(:title, default: @exception.class.name)
        h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
      end
    end
  end
  helper_method :details

end
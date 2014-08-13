class Users::PasswordsController < Devise::PasswordsController
  def new
    super
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?
    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      set_flash_message(:alert, :no_email)
      #flash[:alert] = resource.errors.full_messages.join
      #render text: resource.errors.full_messages.join(', ')
      respond_with(resource) do |format|
        format.html { redirect_to new_user_password_url }
      end
    end
  end
end 

class StaticPagesController < ApplicationController
  include ApplicationHelper
  #before_action :authenticate_user!, only: [:about]
  before_action :no_header_footer!, only: [ :home ]
  
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
  
end

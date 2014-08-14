class StaticPagesController < ApplicationController

  #before_action :authenticate_user!, only: [:about]
  
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
  
end

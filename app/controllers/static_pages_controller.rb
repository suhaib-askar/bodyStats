class StaticPagesController < ApplicationController
  include ApplicationHelper
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

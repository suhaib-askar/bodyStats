class StaticPagesController < ApplicationController
  include ApplicationHelper
  include ProjectsHelper
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

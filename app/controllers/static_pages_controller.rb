class StaticPagesController < ApplicationController
  include ApplicationHelper
  include ProjectsHelper
  before_action :no_header_footer!, only: [ :home ]
  before_action :set_projects, only: [ :home ]
  
  def home
    
  end

  def help
  end

  def about
  end

  def contact
  end
  
private
  def set_projects
    @projects = current_user.projects if current_user.present?
  end
end

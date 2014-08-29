class ProjectsController < ApplicationController
  include ApplicationHelper
  include ProjectsHelper
  before_action :authenticate_user!
  before_action :set_project, only: %w{show edit update destroy more_info}
  before_action :no_header_footer!, only: [ :show ]
  before_action :units, only: [ :show ]
  before_action ->(type=params[:type], count=params[:count]) { more_info_details(type, count) }, only: [ :show ]
  
  def new
    @project = Project.new
  end
  
  def show
    @activities = get_activities
    @last = last_track_item @activities
    @report = report(@project.track_items.send(session[:type], session[:count]))

    #gon.hide_right_block = true if @project.items.empty?
    # "DAYOFMONTH(created_at) = ? or MONTH(created_at) = ?"
    # data = Net::HTTP.get(URI.parse("http://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?"))
  end 
  
  def create
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_items_url(@project) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update_attribute(:image, project_params[:image])
        format.html { redirect_to @project }
        format.js {}
      else
        format.html { redirect_to @project }
      end
    end
  end
  
    
  private 

    def more_info_details(type, count)
      set_more_info(type, count)
    end

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :image)
    end
    
    
end

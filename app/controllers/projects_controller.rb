class ProjectsController < ApplicationController
  include ApplicationHelper
  include ProjectsHelper
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy, :more_info ]
  before_action :no_header_footer!, only: [ :show ]
  before_action :units, only: [ :show ]
  
  def new
    @project = Project.new
  end
  
  def show
    @activities = get_activities
    @last = last_track_item @activities

    type = params[:type].present? ? "for_" + params[:type] : "for_week"
    count = params[:count].present? ? params[:count].to_i : 1
    @report = report(@project.track_items.send(type, count))

    
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

  def more_info
    redirect_to @project
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

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :image)
    end
    
end

class ProjectsController < ApplicationController
  include ApplicationHelper
  include ProjectsHelper
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :no_header_footer!, only: [ :show ]
  before_action :units, only: [ :show ]
  
  def new
    @project = Project.new
  end
  
  def show
    @activities = get_activities(@project)
    @last = last_track_item(@activities)

    #@count_tr = TrackItem.where(item_id: @project.item_ids).count
    #@count_tr = TrackItem.joins(item: :project).where(items: { project_id: @project }).count
    
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

  private 

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
    
end

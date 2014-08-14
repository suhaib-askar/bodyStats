class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]

  def new
    @project = Project.new
  end
  
  def show
    
  end
 
  def create
    #render text: project_params.merge( user_id: current_user.id)
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to track_items_url }
      else
        format.html { render :new }
      end
    end
  end

  private 

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end

end
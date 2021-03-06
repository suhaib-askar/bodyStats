class TrackItemsController < ApplicationController
  include ProjectsHelper
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_item, only: [:create, :update, :destroy]
  before_action :set_project, only: [:create, :update, :destroy]
  before_action :units, only: [ :create, :update, :destroy ]

  def create
    track_item = @item.track_items.build(track_item_params)
    respond_to do |format|
      if track_item.save
        track_item.create_activity :create, owner: @item.project, params: {
          info: { item_name: track_item.item.name, 
                  user_data: track_item.user_data, 
                  unit_id: track_item.item.unit_id,
                  track_item_id: track_item.id } 
        }
        format.html { after_create_path }
        format.js do
          @activities = get_activities
          @last = last_track_item(@activities)
          @report = report(@project.track_items.send(session[:type], session[:count]))
        end
      else
        flash[:errors] = @item.errors.full_messages
        format.html { after_create_path  }
      end
    end
  end

  def update
    # respond_to do |format|
    #   if @item.update_attributes(item_params)
    #     format.html { after_update_path }
    #   else
    #     flash[:errors] = @item.errors.full_messages
    #     format.html { after_update_path }
    #   end
    # end
  end

  def destroy
    track_item = @item.track_items.find(params[:id])
    track_item.create_activity :destroy, owner: @item.project, params: {
      info: { deleted_track_item_id: track_item.id }}
    
    respond_to do |format|
      if track_item.destroy
        format.html { after_destroy_path }
        format.js do
          @activities = get_activities
          @last = last_track_item(@activities)
          @report = report(@project.track_items.send(session[:type], session[:count]))
        end
      end
    end
  end

  private

    def after_create_path
      redirect_to project_url(@item.project)
    end

    def after_update_path
      after_create_path
    end

    def after_destroy_path
      after_create_path
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def set_project
      @project = Project.find(params[:project_id])  
    end
    
    def track_item_params
      params.require(:track_item).permit(:user_data)
    end
end
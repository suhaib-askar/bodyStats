class TrackItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_track_item, only: [:update, :destroy]

  def index
    @project = Project.find(params[:project_id])
    @track_item = TrackItem.new
  end

  def create
    @project = Project.find(params[:project_id])
    @track_item = @project.track_items.build(track_item_params)
    respond_to do |format|
      if @track_item.save
        format.html { after_create_path }
      else
        flash[:errors] = @track_item.errors.full_messages
        format.html { after_create_path  }
      end
    end
  end

  def update
    respond_to do |format|
      if @track_item.update_attributes(track_item_params)
        format.html { after_update_path }
      else
        flash[:errors] = @track_item.errors.full_messages
        format.html { after_update_path }
      end
    end
  end

  def destroy
    @track_item.destroy
    redirect_to project_track_items_url 
  end

  private
    def after_create_path
      redirect_to project_track_items_url
    end

    def after_update_path
      after_create_path
    end

    def set_track_item
      @track_item = TrackItem.find(params[:id])
    end

    def track_item_params
      params.require(:track_item).permit(:name, :unit_id)
    end
end
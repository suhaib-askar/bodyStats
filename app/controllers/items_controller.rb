class ItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_item, only: [:update, :destroy]

  def index
    @project = current_user.projects.find(params[:project_id])
    @item = Item.new
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @item = @project.items.build(item_params)
    respond_to do |format|
      if @item.save
        format.html { after_create_path }
      else
        flash[:errors] = @item.errors.full_messages
        format.html { after_create_path  }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update_attributes(item_params)
        format.html { after_update_path }
      else
        flash[:errors] = @item.errors.full_messages
        format.html { after_update_path }
      end
    end
  end

  def destroy
    @item.destroy
    redirect_to project_items_url 
  end

  private
    def after_create_path
      redirect_to project_items_url
    end

    def after_update_path
      after_create_path
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :unit_id)
    end
end
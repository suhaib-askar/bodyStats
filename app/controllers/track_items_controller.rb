class TrackItemsController < ApplicationController

  before_action :authenticate_user!
  # before_action :set_item, only: [:update, :destroy]

  def create
    @item = Item.find(params[:item_id])
    @track_item = @item.track_items.build(track_item_params)
    respond_to do |format|
      if @track_item.save
        format.html { after_create_path }
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
    # @item.destroy
    # redirect_to project_items_url 
  end

  private

    def after_create_path
      redirect_to project_url(@item.project)
    end

    def after_update_path
      after_create_path
    end

    def set_track_item
      @track_item = TrackItem.find(params[:id])
    end

    def track_item_params
      params.require(:track_item).permit(:user_data)
    end
end
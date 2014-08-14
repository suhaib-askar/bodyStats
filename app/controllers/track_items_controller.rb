class TrackItemsController < ApplicationController

  before_action :authenticate_user!

  def index
    @track_item = TrackItem.new
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

end
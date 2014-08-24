class TrackItem < ActiveRecord::Base
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }


  belongs_to :item
  VALID_DATA_REGEX = /\d/
  validates :user_data, format: { with: VALID_DATA_REGEX}

end
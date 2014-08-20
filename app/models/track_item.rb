class TrackItem < ActiveRecord::Base

  belongs_to :item
  VALID_DATA_REGEX = /\d/
  validates :user_data, format: { with: VALID_DATA_REGEX}

end

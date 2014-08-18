class TrackItem < ActiveRecord::Base

  belongs_to :item
  validates :user_data, numericality: true

end

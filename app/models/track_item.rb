class TrackItem < ActiveRecord::Base

  belongs_to :project
  belongs_to :unit

end

class TrackItem < ActiveRecord::Base
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  #scope :for_project, ->(project){ joins(item: :project).where(items: { project_id: project }).count }
  SCOPE_TYPES = [:week, :hour, :day, :month, :year]
  belongs_to :item
  VALID_DATA_REGEX = /\d/
  validates :user_data, numericality: {greater_than_or_equal_to: 0.01}

  scope :for_hour, ->(hour=1) { where('track_items.created_at >= ?', hour.hour.ago) }
  scope :for_day, ->(day=1) { where('track_items.created_at >= ?', day.day.ago) }
  scope :for_week, ->(week=1) { where('track_items.created_at >= ?', week.week.ago) }
  scope :for_month, ->(month=1) { where('track_items.created_at >= ?', month.month.ago) }
  scope :for_year, ->(year=1) { where('track_items.created_at >= ?', year.year.ago) }
  
end
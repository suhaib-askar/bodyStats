class TrackItem < ActiveRecord::Base
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  #scope :for_project, ->(project){ joins(item: :project).where(items: { project_id: project }).count }

  belongs_to :item
  VALID_DATA_REGEX = /\d/
  validates :user_data, format: { with: VALID_DATA_REGEX}

  def self.for_project(project)
    joins(item: :project).where(items: { project_id: project }).count
  end
end
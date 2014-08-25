class Item < ActiveRecord::Base
  before_save { self.name = name.mb_chars.downcase }
  belongs_to :project
  belongs_to :unit
  has_many :track_items, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 30 }#, uniqueness: { scope: :project_id, case_sensitive: false, message: "already exists on this project" }
  validate :unit
  validate :uniq_item_for_proj
  
  
  
  def unit
    unless unit_id.present?
      errors.add( :unit, 'must be selected' )
    end
  end

  def uniq_item_for_proj
    if Item.exists? ["project_id = ? AND name = ?", project_id, name.mb_chars.downcase]
      errors.add( name, 'already exists on this project' )
    end
  end
  
end

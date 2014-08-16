class Item < ActiveRecord::Base

  belongs_to :project
  belongs_to :unit

  validates :name, presence: true, length: { maximum: 30 }
  validate :unit
  
  def unit
    unless unit_id.present?
      errors.add( :unit, 'must be selected' )
    end
  end

  
end

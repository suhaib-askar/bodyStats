class TrackItem < ActiveRecord::Base

  belongs_to :project
  belongs_to :unit

  validates :name, presence: true, length: { maximum: 30 }
  validate :unit
  
  def unit
    if unit_id.empty?
      errors.add( :unit, 'must be selected' )
    end
  end

end

class Project < ActiveRecord::Base
  extend FriendlyId
  extend Babosa

  friendly_id :name, use: [ :history, :slugged, :finders ]
  
  belongs_to :user
  has_many :items
  
  before_save { name.downcase! }

  validates :name, presence: true, length: { maximum: 30 }#, uniqueness: { scope: :user_id, case_sensitive: false } тоже самое что и метод
  validate :uniq_proj_for_user

  validates :description, presence: true, length: { maximum: 50 }

  

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
  
  def should_generate_new_friendly_id?
    name_changed?
  end

  def uniq_proj_for_user
    if Project.exists? ["user_id = ? AND name = ?", user_id, name]
      errors.add( :name, 'name already exists on this account' )
    end
  end

end

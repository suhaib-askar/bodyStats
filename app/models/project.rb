class Project < ActiveRecord::Base
  extend FriendlyId
  extend Babosa
  before_save { self.name = name.mb_chars.downcase }
  friendly_id :name, use: [ :scoped, :slugged, :finders ], scope: :user
  
  belongs_to :user
  has_many :items
  


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
    if Project.exists? ["user_id = ? AND (name = ? OR slug = ?)", 
                          user_id, 
                          name.mb_chars.downcase, 
                          normalize_friendly_id(name.mb_chars.downcase)
                        ]
      errors.add( :name, 'project already exists on this account' )
    end
  end

end

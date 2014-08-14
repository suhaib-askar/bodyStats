class Project < ActiveRecord::Base

  belongs_to :user

  before_save { name.downcase! }

  validates :name, presence: true, length: { maximum: 30 }#, uniqueness: { scope: :user_id, case_sensitive: false } тоже самое что и метод
  validate :uniq_proj_for_user

  validates :description, presence: true, length: { maximum: 50 }

  

  
  def uniq_proj_for_user
    if Project.exists? ["user_id = ? AND name = ?", user_id, name]
      errors.add( :name, 'name already exists on this account' )
    end
  end

end

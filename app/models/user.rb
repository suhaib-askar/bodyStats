class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 30 }
  has_many :projects, dependent: :destroy

  belongs_to :role
  before_create :set_default_role

  def role?(role)
    self.role.name == role.to_s
  end

  def active_for_authentication?
    super && self.role.name != 'banned'
  end

private
  
  def set_default_role
    self.role ||= Role.find_by(name: 'registered')
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 30 }
  has_many :projects, dependent: :destroy

  

  # has_many :microposts, dependent: :destroy
  # has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  # has_many :reverse_relationships, foreign_key: "followed_id",
  #                                  class_name:  "Relationship",
  #                                  dependent:   :destroy
  # has_many :followers, through: :reverse_relationships, source: :follower
  # has_many :followed_users, through: :relationships, source: :followed
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :name, presence: true, length: { maximum: 50 }
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # validates :password, length: { minimum: 6 }
  # before_save { email.downcase! }
  # before_create :create_remember_token



end

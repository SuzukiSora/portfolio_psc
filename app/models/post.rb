class Post < ApplicationRecord
  
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 255 }
  validates :cast, presence: true, length: { maximum: 255 }

  has_many :reverses_of_like, class_name: 'like', foreign_key: 'user_id'
  has_many :users, through: :reverses_of_like

  # ranking
   has_many :liked_users, through: :likes, source: :user  


end

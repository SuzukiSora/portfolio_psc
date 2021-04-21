class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :posts

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :likes
  has_many :likings, through: :likes, source: :post


  # ranking
  has_many :liked_posts, through: :likes, source: :post



  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def like(other_post)
    unless self == other_post
      self.likes.find_or_create_by(post_id: other_post.id)
    end
  end

  def unlike(other_post)
    like = self.likes.find_by(post_id: other_post.id)
    like.destroy if like
  end

  def liking?(other_post)
    self.likings.include?(other_post)
  end

end

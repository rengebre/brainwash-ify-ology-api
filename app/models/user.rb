class User < ApplicationRecord
  has_many :followed_follows, class_name: 'Follow', foreign_key: 'followed_id'
  has_many :follower_follows, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :interests, through: :user_interest
  has_many :comments
  has_many :posts
  has_many :likes
end

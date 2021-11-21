class Post < ApplicationRecord
  belongs_to :users
  belongs_to :interests
  has_many :likes
  has_many :comments
end
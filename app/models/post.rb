class Post < ApplicationRecord
  belongs_to :users, :interests
  has_many :likes, :comments
end
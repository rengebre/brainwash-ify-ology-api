class Post < ApplicationRecord
  belongs_to :user
  belongs_to :interest
  has_many :likes
  has_many :comments
  has_one_attached :upload_file
end
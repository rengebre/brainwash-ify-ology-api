class Post < ApplicationRecord
  belongs_to :user
  belongs_to :interest
  has_many :likes
  has_many :comments
  has_one_attached :upload_file
  has_one_attached :thumbnail

  def content_type_upload_file
    self.upload_file.blob.content_type
  end

  def content_type_thumbnail
    self.thumbnail.blob.content_type
  end
end
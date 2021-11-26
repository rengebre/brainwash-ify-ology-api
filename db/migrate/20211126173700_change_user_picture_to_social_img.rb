class ChangeUserPictureToSocialImg < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :picture, :social_img
  end
end

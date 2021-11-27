class RemoveAttachmentColumnsFromPostsUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :upload_file
  end
end

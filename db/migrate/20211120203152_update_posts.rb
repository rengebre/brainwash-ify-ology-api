class UpdatePosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :upload_file, :string
    add_column :posts, :post_type, :string
  end
end

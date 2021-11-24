class UpdateUserWithSocialData < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :social_id, :string
  end
end

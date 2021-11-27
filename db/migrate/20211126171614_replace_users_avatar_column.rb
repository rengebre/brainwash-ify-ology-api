class ReplaceUsersAvatarColumn < ActiveRecord::Migration[6.1]
  change_table :users do |t|
    t.remove :avatar
    t.string :picture
  end
end

class AddForeignKeyToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :user
    add_reference :posts, :interest

    add_foreign_key :posts, :users, column: :user_id
    add_foreign_key :posts, :interests, column: :interest_id
  end
end

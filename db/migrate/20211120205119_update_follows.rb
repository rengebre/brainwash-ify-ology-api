class UpdateFollows < ActiveRecord::Migration[6.1]
  def change
    add_reference :follows, :followed
    add_reference :follows, :follower

    add_foreign_key :follows, :users, column: :followed_id
    add_foreign_key :follows, :users, column: :follower_id
  end
end

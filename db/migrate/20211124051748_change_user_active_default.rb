class ChangeUserActiveDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :active, true
  end
end

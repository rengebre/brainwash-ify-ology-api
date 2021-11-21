class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :username
      t.string :bio
      t.boolean :active
      t.string :avatar

      t.timestamps
    end
  end
end

class Like < ApplicationRecord
  belongs_to :users, :posts
end

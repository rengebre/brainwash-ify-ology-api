class Interest < ApplicationRecord
  has_many :users, through: :user_interest
  has_many :posts
end

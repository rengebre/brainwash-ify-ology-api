class Interest < ApplicationRecord
  has_many :user_interests, :posts
end

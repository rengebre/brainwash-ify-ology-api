class UserInterest < ApplicationRecord
  belongs_to :users, :interests
end

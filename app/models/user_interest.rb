class UserInterest < ApplicationRecord
  belongs_to :users
  belongs_to :interests
end

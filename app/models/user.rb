class User < ApplicationRecord
  validates :email, uniqueness: true

  has_many :user_parties
  has_many :viewing_parties, through: :user_parties
end

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :user_parties
  has_many :viewing_parties, through: :user_parties
end

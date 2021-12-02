# class DurationValidator < ActiveModel::Validator
#   def validate(record)
#     facade = MovieFacade.new
#     runtime = facade.movie_details(record.movie_id)[:runtime]

#     if record.duration < runtime
#       record.errors[:base] << "Duration must be equal to or greater than movie runtime"
#     end
#   end
# end

class ViewingParty < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :movie_id, presence: true
  validates :host_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  # validates_with DurationValidator
end

class Lesson < ActiveRecord::Base
  has_many :bookings
  belongs_to :gym
end

#
# Agent Model
#
# @author [nityamvakil]
#
class Agent < ActiveRecord::Base
  validates_presence_of :secret_key, :decode_key
  validates_uniqueness_of :secret_key, :decode_key

  has_many :tasks
  has_many :bookings

  attr_reader :encoded_key

  #
  # TODO: Key signing!
  #
  def encoded_key
    secret_key
  end
end

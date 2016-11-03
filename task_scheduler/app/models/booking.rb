class Booking < ActiveRecord::Base
  belongs_to :agent
  belongs_to :lesson

  def cancel
    puts self.lesson.id
    puts self.agent.id
  end
end

class CreateBooking < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :agent_id
      t.integer :lesson_id
    end
  end
end

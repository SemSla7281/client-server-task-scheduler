class CreateLesson < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :gym_id
      t.datetime :start_time
    end
  end
end

class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :path, null: false
      t.string :arguments
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :weekdays, null: false, array: true
      t.string :status, null: false, default: 'scheduled'
      t.integer :agent_id, null: false

      t.timestamps null: false
    end
  end
end

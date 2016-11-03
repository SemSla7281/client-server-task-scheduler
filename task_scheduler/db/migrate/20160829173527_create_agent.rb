class CreateAgent < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :secret_key, null: false
      t.string :decode_key, null: false

      t.timestamps null: false
    end
  end
end

class Gym < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :address
    end
  end
end

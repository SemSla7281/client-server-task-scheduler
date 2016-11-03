class AddColumnRunToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :is_active, :boolean, default: false
  end
end

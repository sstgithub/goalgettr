class AddEstTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :est_time, :string
  end
end

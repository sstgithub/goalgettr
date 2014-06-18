class AddDueDatetimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due_datetime, :datetime
  end
end

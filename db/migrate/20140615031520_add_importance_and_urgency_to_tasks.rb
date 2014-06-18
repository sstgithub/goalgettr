class AddImportanceAndUrgencyToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :importance, :string
    add_column :tasks, :urgency, :string
  end
end

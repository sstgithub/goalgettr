class ChangeImportanceAndUrgencyFormatInTasks < ActiveRecord::Migration
  def change
  	remove_column :tasks, :importance, :string
  	remove_column :tasks, :urgency, :string
  	add_column :tasks, :importance, :integer
  	add_column :tasks, :urgency, :integer
  end
end

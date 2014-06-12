class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.integer :user_id
    	t.string :task_name
    	t.string :description
    	t.string :status

      t.timestamps
    end
  end
end

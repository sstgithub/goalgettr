class AddMoreAddressAttributesToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :street_number, :string
    add_column :tasks, :route, :string
    add_column :tasks, :state, :string
    add_column :tasks, :statetwo, :string
  end
end

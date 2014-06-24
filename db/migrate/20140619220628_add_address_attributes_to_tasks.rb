class AddAddressAttributesToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :city, :string
    add_column :tasks, :zipcode, :string
    add_column :tasks, :street_address, :string
  end
end

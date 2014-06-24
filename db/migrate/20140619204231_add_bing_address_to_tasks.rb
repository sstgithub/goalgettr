class AddBingAddressToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :bing_address, :string
  end
end

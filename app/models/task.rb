# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  task_name   :string(255)
#  description :string(255)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Task < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :importance
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end

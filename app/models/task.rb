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

# require 'httparty'

class Task < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :importance
	geocoded_by :address
	reverse_geocoded_by :latitude, :longitude do |obj, results|
		if geo = results.first
			obj.street_number = geo.street_number
			obj.route = geo.route
			obj.state = geo.state
			obj.city = geo.city
			# obj.street_address = geo.street_address
			obj.zipcode = geo.postal_code
			obj.street_address = geo.street_address
		end
	end

	after_validation :geocode, :if => :address_changed?
	after_validation :reverse_geocode

	def set_bing_address_from_bing
		bing_data = get_bing_data
		address = bing_data["resourceSets"][0]["resources"][0]["address"]["formattedAddress"]
		self[:bing_address] = address
		self.save
	end

	def get_bing_data
		HTTParty.get('http://dev.virtualearth.net/REST/v1/Locations/@task.latitude.to_i,@task.longitude.to_i?key=Ah_f4EtXujIKRwM2DMfcrhaL_XJ0G_Ob_Yyy1nlDf0X_LYGhJilPBjWSfI91E3MV')
	end
end

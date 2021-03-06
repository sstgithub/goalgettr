module TasksHelper
	def status_type
		[
			"Pending",
			"Completed",
			"Canceled"
		]
	end

	def travel_time(first_task, second_task)
		if first_task.street_address && second_task.street_address
      t_street_address = first_task.street_address.split("-").last
      a_street_address = second_task.street_address.split("-").last
    end

    if t_street_address && a_street_address
      response = HTTParty.get("http://dev.virtualearth.net/REST/V1/Routes?wp.0=#{format_string(t_street_address)}%20#{format_string(first_task.city)},#{format_string(first_task.state)}&wp.1=#{format_string(a_street_address)}%20#{format_string(second_task.city)},#{format_string(second_task.state)}&optmz=timeWithTraffic&key=Ah_f4EtXujIKRwM2DMfcrhaL_XJ0G_Ob_Yyy1nlDf0X_LYGhJilPBjWSfI91E3MV")
		end

    if response["resourceSets"][0]["resources"][0]["travelDurationTraffic"]
      "#{distance_of_time_in_words(response["resourceSets"][0]["resources"][0]["travelDurationTraffic"])} driving time"
    else 
    	"Travel Time Unavailable"
    end
  end

  def format_string(str)
  	str.gsub(' ','%20')
  end



end

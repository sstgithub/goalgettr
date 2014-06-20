module ApplicationHelper
	def format_date(date)
    if date
      date.strftime("%B %d, %Y")
    else
      "Date not specified"
    end
  end

  def format_time(time)
  	if time
  		time.strftime("%l:%M %p")
  	else
  		"Time not specified"
  	end
  end

end

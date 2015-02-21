module ApplicationHelper
	# helper_method :time_to_string
	# convert time in seconds to a string
	def time_to_string(time)
		if !time.nil?
			Time.at(time).strftime("%Y-%m-%d %H:%M")
		else
			"Unknown"
		end
	end

	# helper_method :time_in_h_mm
	# converts seconds to a H:MM
	def time_in_h_mm(seconds)
		if !seconds.nil?
			Time.at(seconds).utc.strftime("%H:%M")
		else
			"00:00"
		end
	end		

end

module ApplicationHelper
	# convert ruby time to a string without GMT reference
	def timeUTC_to_date_time(time)
		if !time.nil?
			Time.at(time).strftime("%Y-%m-%d %H:%M")
		else
			"Unknown"
		end
	end

	def timeUTC_to_date(timeUTC)
		timeUTC.getlocal.strftime("%Y-%b-%d")
	end

	def timeUTC_to_time(time)
		time.getlocal.strftime("%I:%M %P")
	end

	def time_to_date_string(time)
		if !time.nil?
			Time.at(time).strftime("%Y-%m-%d")
		else
			"Unknown"
		end
	end

	def minutes_to_hours(minutes)
		(minutes / 60.0).round(1)
	end

	def project_client(project)
		project.client
	end

	def task_client(task)
		task.project.client
	end

	# # converts seconds to a H:MM
	# def time_in_h_mm(seconds)
	# 	if !seconds.nil?
	# 		Time.at(seconds).utc.strftime("%H:%M")
	# 	else
	# 		"00:00"
	# 	end
	# end		

end

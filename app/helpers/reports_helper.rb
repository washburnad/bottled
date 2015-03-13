module ReportsHelper
	
	def report_options
		types = [ 'Client' , 'Project' , 'Task' , 'User' ]
		options = []
		types.each do |t|
			selected = (t.downcase == @type)? "selected='selected'" : " "
			options << [ t , t.downcase , selected ]
		end
		return options
	end
	
end

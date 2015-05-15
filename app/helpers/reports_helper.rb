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

	def show_report(report, include_glyph)
	  display = include_glyph ? glyph_for(report.reportable.client) : ""
	  display += link_to report.name, report_path(report) 
	end
end

class ReportsController < ApplicationController
	def index
		@clients = Client.all
		@type = type_param[:type]
	end


	private

	helper_method :report_options
	def report_options
		types = [ 'Client' , 'Project' , 'Task' , 'User' ]
		options = []
		types.each do |t|
			selected = (t.downcase == @type)? "selected='selected'" : " "
			options << [ t , t.downcase , selected ]
		end
		return options
	end


	def type_param
		type = params.permit(:type)
	end


end

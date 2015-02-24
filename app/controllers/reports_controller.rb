class ReportsController < ApplicationController
	def index
		@clients = Client.all
		@projects = Project.all
		@type = type_param[:type]
	end


	def query
		puts query_params
		if query_params[:client_id]
			@projects = Client.find( query_params[:client_id]).projects.all
			render :json => '@projects'
		elsif query_params[:project_id]
			@tasks = Project.find( query_params[:project_id]).tasks.all 
			render :json => '@tasks'
		else
			render :text => 'unprocessable_entity', :status => :unprocessable_entity
		end
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

	
	helper_method :show_projects
	def show_projects
		return true
	end

	def query_params
		@query_params = params.permit( :client_id, :project_id )
	end

	def type_param
		@type_param = params.permit(:type)
	end


end

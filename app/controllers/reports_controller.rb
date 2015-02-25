class ReportsController < ApplicationController
	before_action :authenticate_user!

	def index
		@clients = current_user.clients.all
		@type = report_params[:type]
		if report_params[:client_id]
			@projects = current_user.clients.find( report_params[:client_id] ).projects.all

			respond_to do |format|
			  format.html { render :partial => 'projects_select' }
			end
		else
			# @projects = Project.all
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

	def report_params
		@report_params = params.permit(:type, :client_id, :project_id)
	end


end

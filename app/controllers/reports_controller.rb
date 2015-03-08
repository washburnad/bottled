class ReportsController < ApplicationController
	before_action :authenticate_user!

	def index
		@reports = Report.all
		@clients = current_user.clients.all
		@type = report_params[:type]
		if report_params[:client_id]
			@projects = current_user.clients.find( report_params[:client_id] ).projects.all

			respond_to do |format|
			  format.html { render :partial => 'projects_select' }
			end
		elsif report_params[:project_id]
			@tasks = Project.find( report_params[:project_id] ).tasks.all 

			respond_to do |format|
				format.html { render :partial => 'tasks_select' }
			end
		end

	end

	def show 
		@report = Report.find(params[:id])
	end

	private

	def report_params
		@report_params = params.permit(:type, :client_id, :project_id, :task_id, :start_date, :end_date)
	end


end

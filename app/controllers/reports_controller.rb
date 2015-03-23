class ReportsController < ApplicationController
	before_action :authenticate_user!
	before_action :remove_unassigned! , :only => [:index]

	def index
		@reports = Report.all
		@clients = current_user.clients.to_a
		
		if params[:client_id]
			@projects = current_user.clients.find( params[:client_id] ).projects.to_a

			respond_to do |format|
			  format.html { render :partial => 'projects_select' }
			end
		elsif params[:project_id]
			@tasks = Project.find( params[:project_id] ).tasks.all 

			respond_to do |format|
				format.html { render :partial => 'tasks_select' }
			end
		end
	end

	def show 
		@report = Report.find(params[:id])
		@context = context(@report)
		if @context.nil?
			redirect_to reports_path
		end
	end

	def edit 
		@report = Report.find(params[:id])
		@context = context(@report)
		if @context.nil?
			redirect_to reports_path
		else
			redirect_to report_path(@report)
		end
	end

	def create
		@report = Report.create
		@report.update_attributes(create_params)
		if @report.valid?
			render :json => { redirect_url: report_path(@report) }
		else
			render :text, :status => :unprocessable_entity
		end
	end

	def update
		@report = Report.find(params[:id])
		@report.update_attributes(report_params)
		if @report.valid?
			redirect_to report_path(@report)
		else 
			render :text, status: :unprocessable_entity
		end
	end

	private

	def report_params
		@report_params = params.require(:report).permit(:name, :reportable_type, :reportable_id, :start_date, :end_date)
	end

	def create_params
		@create_params = params.permit(:name, :reportable_type, :reportable_id, :start_date, :end_date)
	end


	# def query_params
	# 	@query_params = params.permit(:client_id, :project_id)
	# end

	def remove_unassigned!
	  @unassigned = Report.where( reportable_id: nil ).destroy_all
	end

	def context( reportable )
		type = reportable.reportable_type
		puts type
		id = reportable.reportable_id
		puts id
		case type
		when 'User'
			@context = User.find(id)
		when 'Client'
			@context = Client.find(id)
		when 'Project'
			@context = Project.find(id)
		when 'Task'
			@context = Task.find(id)
		end

	end
end

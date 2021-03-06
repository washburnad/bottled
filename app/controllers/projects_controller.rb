class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized

	def index
		@projects = current_client.projects.to_a
	end

	def new
		@project = Project.new

	end

	def create
		@project = current_client.projects.create(project_params)
		if @project.valid?
			redirect_to client_project_path(current_client, @project)
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def show 
		@project = Project.includes(:tasks).find(params[:id])
		@tasks = @project.tasks
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		@project.update_attributes(project_params)
		if @project.valid?
			redirect_to client_project_path(current_client, @project)
		else
			render :new, :status => :unprocessable_entity
		end
	end



	private

	helper_method :current_client
	def current_client
		@current_client ||= Client.find(params[:client_id])
	end

	def require_authorized
		if current_client.user != current_user
			redirect_to root_path, alert: 'Current user does not have access to that page.'
		end
	end

	def project_params
		params.require(:project).permit(:name, :description)
	end
end

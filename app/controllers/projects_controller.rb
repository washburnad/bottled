class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_user

	def index
		@projects = current_client.projects.all
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
		@project = Project.find(params[:id])
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

	def require_authorized_user
		if current_client.user != current_user
			render :text => 'Unauthorized', :status => :unauthorized
		end
	end

	def project_params
		params.require(:project).permit(:name, :description)
	end
end

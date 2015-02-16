class TasksController < ApplicationController
	before_action :authenticate_user!

	def index
		@tasks = current_project.tasks.all
	end

	def new
		@task = Task.new
	end

	def show
		@task = Task.find(params[:id])
	end

	def create
		@task = current_project.tasks.create(task_params)
		if @task.valid?
			redirect_to project_task_path(current_project, @task)
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		@task.update_attributes(task_params)
		if @task.valid?
			redirect_to project_task_path(current_project, @task)
		else
			render :new, :status => :unprocessable_entity
		end
	end

	private

	helper_method :current_project
	def current_project
		@current_project ||= Project.find(params[:project_id])
	end

	helper_method :current_client
	def current_client
		@current_client ||= Client.find(current_project.client_id)
	end

	def task_params
		params.require(:task).permit(:name)
	end
end

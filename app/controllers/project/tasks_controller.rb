class Project::TasksController < ApplicationController

	def index

	end

	def new
		@task = Task.new
	end

	def create

	end

	def show

	end

	def edit

	end

	def update

	end

	private

	helper_method
	def current_project
		@current_project ||= current_user.projects.find(params[:project_id])
	end

	def task_params
		params.require(:task).permit(:name)
	end
end

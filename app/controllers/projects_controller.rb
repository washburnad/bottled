class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_user

	def index

	end

	def new
		@project = Project.new

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

	helper_method :current_client
	def current_client
		@current_client ||= Client.find(params[:client_id])
	end

	def require_authorized_user
		if current_client.user != current_user
			render :text => 'Unauthorized', :status => :unauthorized
		end
	end
end

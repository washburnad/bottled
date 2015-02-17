class HomeController < ApplicationController

	def index
		@clients = current_user.clients.order("updated_at").limit(3)
		@projects = current_user.projects.all
		@tasks = current_user.tasks.all
	end
end

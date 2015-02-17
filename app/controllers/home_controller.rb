class HomeController < ApplicationController

	def index
		@clients = current_user.clients.order("updated_at").limit(3)
		@projects = current_user.projects.order("updated_at").limit(3)
		@tasks = current_user.tasks.order("updated_at").limit(3)
	end

end

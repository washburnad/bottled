class HomeController < ApplicationController

	def index
		if current_user
			@clients = current_user.clients.order("updated_at").limit(3)
			@projects = current_user.projects.order("updated_at").limit(3)
			@tasks = current_user.tasks.order("updated_at").limit(3)
		  @reports = current_user.reports.order("updated_at").limit(3)
    end
	end

end

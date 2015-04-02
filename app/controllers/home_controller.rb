class HomeController < ApplicationController

	def index
		if current_user
			@clients = current_user.all_clients('update_at').first(5)
			@projects = current_user.all_projects('updated_at').first(5)
			@tasks = current_user.all_tasks('updated_at').first(5)
		  @reports = current_user.global_reports.order("updated_at").limit(3)
    end
	end

end

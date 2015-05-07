class HomeController < ApplicationController

	def index
		if current_user
			@clients = current_user.all_clients.first(5)
			@projects = current_user.all_projects.first(5)
			@tasks = current_user.all_tasks.first(5)
		  @reports = current_user.global_reports.order("updated_at").to_a.last(5).reverse
    end
	end

  def about
  end
end

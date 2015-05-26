class UsersController < ApplicationController

  before_action :authenticate_user!
  
  def project_index
    @projects = current_user.all_projects
  end

  def task_index
    @tasks = current_user.all_tasks
  end
	
end

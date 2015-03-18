class UsersController < ApplicationController

  before_action :authenticate_user!
  
  def project_index
    @projects = current_user.projects.to_a
  end

  def task_index
    @tasks = current_user.tasks.to_a
  end

	
end

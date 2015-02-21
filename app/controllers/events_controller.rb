class EventsController < ApplicationController

	def index
		@events = current_task.events.order('created_at DESC').all
	end

	def create
		@event = current_task.events.create(event_params)
		
		render :json => {
				:update_url => task_event_path(current_task, @event)
				}
	end

	def show
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		@event.update_attributes(event_params)

		render :json => {
				:update_url => task_event_path(current_task, @event)
				}
	end

	private

	helper_method :current_task
	def current_task
		@current_task ||= Task.find(params[:task_id])
	end

	helper_method :current_project
	def current_project
		@current_project ||= Project.find(current_task.project_id)
	end

	helper_method :current_client
	def current_client
		@current_client ||= Client.find(current_project.client_id)
	end

	def event_params
		params.require(:event).permit(:name, :description, :start_time, :end_time, :duration)
	end
end

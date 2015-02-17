class EventsController < ApplicationController

	def create
		@task = Task.find(params[:task_id])
		@event = @task.events.create(event_params)
		
		render :json => {
				:update_url => task_event_path(@task, @event)
				}
	end

	def update
		@task = Task.find(params[:task_id])
		@event = Event.find(params[:id])
		@event.update_attributes(event_params)

		render :json => {
				:event_id => @event.id
		}
	end

	private

	def event_params
		params.require(:event).permit(:name, :description, :start_time, :end_time, :duration)
	end
end

class EventsController < ApplicationController

	def create
		@event = Event.create(event_params)
		render :text => 'updated'
	end

	private

	def event_params
		params.require(:event).permit(:name, :description, :start_time, :end_time)
	end
end

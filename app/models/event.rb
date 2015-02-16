class Event < ActiveRecord::Base
	belongs_to :project

	validates :start_time, :presence => true
end

class Task < ActiveRecord::Base
	belongs_to :project
	has_many :events

	validates :name, :presence => true
end

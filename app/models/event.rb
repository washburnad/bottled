class Event < ActiveRecord::Base
  belongs_to :task
	has_one :project, through: :events
  has_one :client, through: :projects
  has_many :reports, as: :reportable

	validates :start_time, :presence => true


end

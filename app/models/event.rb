class Event < ActiveRecord::Base
	belongs_to :project
  has_many :reports, as: :reportable

	validates :start_time, :presence => true


end

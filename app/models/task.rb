class Task < ActiveRecord::Base
	belongs_to :project
	has_many :events
  has_many :reports, as: :reportable

	validates :name, :presence => true
end

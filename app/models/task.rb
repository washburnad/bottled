class Task < ActiveRecord::Base
	belongs_to :project
	has_many :events
  has_one :client, through: :project
  has_many :reports, as: :reportable

	validates :name, :presence => true
end

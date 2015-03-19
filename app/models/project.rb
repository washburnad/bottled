class Project < ActiveRecord::Base
	belongs_to :client
	belongs_to :user
	has_many :tasks
  has_many :events, through: :tasks
  has_many :reports, as: :reportable

	validates :name, :presence => true
end

class Project < ActiveRecord::Base
	belongs_to :client
	belongs_to :user
	has_many :tasks

	validates :name, :presence => true
end

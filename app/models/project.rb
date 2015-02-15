class Project < ActiveRecord::Base
	belongs_to :client
	belongs_to :user

	validates :name, :presence => true
end

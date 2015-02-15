class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects

	validates :name, :presence => true
end

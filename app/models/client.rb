class Client < ActiveRecord::Base
	has_one :user
	has_many :projects

	validates :name, :presence => true
end

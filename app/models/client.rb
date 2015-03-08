class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :reports, as: :reportable

	validates :name, :presence => true
end

class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :tasks, through: :projects
  has_many :events, through: :projects
  has_many :reports, as: :reportable
  has_many :collaborations

	validates :name, :presence => true

  include Collaborations
  
end


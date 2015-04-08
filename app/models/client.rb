class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :tasks, through: :projects
  has_many :events, through: :projects
  has_many :reports, as: :reportable
  has_many :collaborations

	validates :name, :presence => true

  include Collaborations
  
  def all_projects
    collaborating_projects = collaborations.map { |c| c.client.projects }
    projects + collaborating_projects.flatten.uniq
  end

  def amount_billable
    events.to_a.sum(&:amount_billable)
  end

  def duration
    events.to_a.sum(&:duration)
  end
  
end


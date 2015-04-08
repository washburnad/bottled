class Task < ActiveRecord::Base
	belongs_to :project
	has_many :events
  has_one :client, through: :project
  has_one :user, through: :project
  
  has_many :reports, as: :reportable

	validates :name, :presence => true

  def billing_rate
    super || project.billing_rate
  end

  def amount_billable
    events.to_a.sum(&:amount_billable)
  end

  def duration
    events.to_a.sum(&:duration)
  end
end

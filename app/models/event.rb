class Event < ActiveRecord::Base
  belongs_to :task
	has_one :project, through: :task
  has_one :client, through: :project
  has_one :user, through: :client
  has_many :reports, as: :reportable
  
	validates :start_time, :presence => true

  def amount_billable
    client.billing_rate.present? ? client.billing_rate / 60 * duration : 0
  end

end

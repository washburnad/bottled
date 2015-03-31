class Project < ActiveRecord::Base
	belongs_to :client
	has_many :tasks
  has_many :events, through: :tasks
  has_one :user, through: :Project

  has_many :reports, as: :reportable

	validates :name, :presence => true

  def billing_rate
    super || client.billing_rate
  end
end

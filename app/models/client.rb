class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :tasks, through: :projects
  has_many :events, through: :projects
  has_many :reports, as: :reportable
  has_many :collaborations

	validates :name, :presence => true

  include Collaborations
  
  # Amount billable per seconds from billing_rate for calculation
  def bill_per_second
    billing_rate.present? ? billing_rate / (60 * 60) : 0
  end

  # Amount billable per minute from billing_rate for calculation
  def bill_per_minute
    billing_rate.present? ? billing_rate / 60 : 0
  end

end


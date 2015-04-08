class User < ActiveRecord::Base
	has_many :clients
	has_many :projects, :through => :clients
	has_many :tasks, :through => :projects
  has_many :reports, as: :reportable
  has_many :global_reports, foreign_key: :user_id, class_name: 'Report'
  has_many :collaborations
  has_many :collaborating_clients, :through => :collaborations, :source => :client
  has_many :collaborating_projects, :through => :collaborating_clients, :source => :projects
  has_many :collaborating_tasks, :through => :collaborating_clients, :source => :tasks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # takes string input of either user.id or user.email and returns user object
  def self.user_from_id_or_email(user_string)
    if user_string.to_i.to_s == user_string
      user_id = user_string.to_i
      User.find(user_id)
    else
      User.find_by(email: user_string)
    end
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def all_clients(sort = 'updated_at')
    clients.to_a.concat(collaborating_clients.to_a).uniq.sort_by { |c| c[sort] }
  end

  def all_projects(sort = 'updated_at')
    projects.to_a.concat(collaborating_projects.to_a).uniq.sort_by { |p| p[sort] }
  end

  def all_tasks(sort = 'updated_at')
    tasks.to_a.concat(collaborating_tasks.to_a).uniq.sort_by { |t| t[sort] }
  end

  def amount_billable
    events.to_a.sum(&:amount_billable)
  end

  def duration
    events.to_a.sum(&:duration)
  end
end

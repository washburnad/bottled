class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :tasks, through: :projects
  has_many :events, through: :projects
  has_many :reports, as: :reportable
  has_many :collaborations

	validates :name, :presence => true

  def add_collaborator(collaborating_user)
    if user.id != collaborating_user.id 
      collaborations.create(user: collaborating_user)
    end
  end

end


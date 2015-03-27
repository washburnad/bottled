class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :tasks, through: :projects
  has_many :events, through: :projects
  has_many :reports, as: :reportable
  has_many :collaborations

	validates :name, :presence => true

  def add_collaborator(collaborating_user)
    return false unless collaborating_user.present?
    return false if user.id == collaborating_user.id
    # return false if is_collaborator?(collaborating_user)
    c = collaborations.create(user: collaborating_user)
  end

  def self.collaborating_user(collaboration_params)
    collaborator_string = collaboration_params[:collaborator_string]
    collaborating_user = User.user_from_id_or_email(collaborator_string)
  end

  def collaborator?(user)
    collaborators.any? { |c| c == user }
  end

  def collaborators
    collaborations.map { |c| User.find(c["user_id"]) }
  end

end


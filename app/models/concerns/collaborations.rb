module Collaborations
  def add_collaborator(collaborating_user)
    return false unless collaborating_user.present?
    return false if user.id == collaborating_user.id
    # return false if is_collaborator?(collaborating_user)
    c = collaborations.create(user: collaborating_user)
  end

  def collaborator?(user)
    collaborators.any? { |c| c == user }
  end

  def collaborators
    collaborations.map { |c| User.find(c["user_id"]) }
  end

  # class method to find a collaborating user from collaboration_params passed to the client controller
  def Client.collaborating_user(collaboration_params)
    collaborator_string = collaboration_params[:collaborator_string]
    collaborating_user = User.user_from_id_or_email(collaborator_string)
  end
end
class Client < ActiveRecord::Base
	belongs_to :user
	has_many :projects
  has_many :tasks, through: :projects
  has_many :events, through: :projects
  has_many :reports, as: :reportable
  has_many :collaborations

	validates :name, :presence => true

  def add_collaborator(user)
    puts "adding collaborator"
    collaboration = Collaboration.create(client_id: id, user_id: user.id)
    if collaboration.valid? 
      puts "collaboration saved" 
    else
      puts "collaboration not saved"
    end
  end

end

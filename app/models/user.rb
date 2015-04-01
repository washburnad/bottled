class User < ActiveRecord::Base
	has_many :clients
	has_many :projects, :through => :clients
	has_many :tasks, :through => :projects
  has_many :reports, as: :reportable
  has_many :global_reports, foreign_key: :user_id, class_name: 'Report'
  has_many :collaborations

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
    name = first_name.present? ? first_name : ""
    name += " " 
    name += last_name.present? ? last_name : ""
  end

end

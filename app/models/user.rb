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
end

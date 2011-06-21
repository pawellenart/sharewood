class ParticipationValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:admin] << "can't be assigned to any projects" if
      record.admin && !record.projects.empty?
  end
end

class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_one :profile
  has_many :comments
  has_many :documents
  
  validates_with ParticipationValidator
  
  accepts_nested_attributes_for :profile
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :profile_attributes
end

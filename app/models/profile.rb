class Profile < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true

  has_attached_file :avatar,
    :default_url => 'avatars/medium/missing.gif',
    :styles => { :medium => "100x100#", :thumb => "30x30#" }
end

class Document < ActiveRecord::Base
  has_attached_file :resource

  belongs_to :project
  belongs_to :user
end

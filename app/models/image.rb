class Image < ActiveRecord::Base
  attr_accessible :file
  has_attached_file :file
  validates :file, :attachment_presence => true
end

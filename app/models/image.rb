class Image < ActiveRecord::Base
  attr_accessible :file
  has_attached_file :file,
    :path => ":class/:attachment/:id/:basename.:extension"

  validates :file, :attachment_presence => true
end

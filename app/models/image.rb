class Image < ActiveRecord::Base
  attr_accessible :file
  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates :file, :attachment_presence => true
end

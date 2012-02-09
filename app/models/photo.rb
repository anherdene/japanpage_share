class Photo < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image, :styles => { :small => "145x145#", :normal => "640x480>"},
                    :url => "/images/albums/users/:id/:basename_:style.:extension",
                    :path => ":rails_root/public/images/albums/users/:id/:basename_:style.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end

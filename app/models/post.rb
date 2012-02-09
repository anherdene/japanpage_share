class Post < ActiveRecord::Base

  belongs_to :user, :foreign_key => "sender_id"
  validates_presence_of :message
  scope :find_user_posts, lambda {|user| where(["recepient_id=?", user.id]) }

end

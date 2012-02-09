class User < ActiveRecord::Base

  has_many :friendships,
           :conditions => { :is_confirmed => true }

  has_many :friends,
           :through => :friendships

  has_many :inverse_friendships,
           :conditions => { :is_confirmed => true },
           :class_name => "Friendship",
           :foreign_key => :friend_id

  has_many :inverse_friends,
           :through => :inverse_friendships,
           :source => :user

  has_many :friendship_requests,
           :class_name => "Friendship",
           :foreign_key => "friend_id",
           :conditions => { :is_confirmed => nil }

  has_many :potential_friends,
           :through => :friendship_requests,
           :source => :user

  has_many :wanted_friendships, :class_name => "Friendship",
           :conditions => { :is_confirmed => nil }

  has_many :wanted_friends, :through => :wanted_friendships,
           :source => :friend

  has_many :photos

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :profile => "280x210#", :post => "90x90#" },
                    :url => "/images/users/:id/:basename_:style.:extension",
                    :path => ":rails_root/public/images/users/:id/:basename_:style.:extension",
                    :default_url => "/images/missing_:style.jpg"

  validates_presence_of :name, :surname
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :surname, :nickname, :birthday, :sex, :country, :city,
                  :phone, :skype, :university, :school, :interests, :address,
                  :email, :password, :password_confirmation, :remember_me, :friend, :friendship,
                  :inverse_friend, :inverse_friendship, :id, :status,
                  :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at,
                  :image_file_name,:image_content_type,:image_file_size,:image_updated_at, :user_id, :name,:created_at,:updated_at


  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  def friendship(user)
    Friendship.find_by_user_id_and_friend_id(self.id, user.id) || Friendship.find_by_user_id_and_friend_id(user.id, self.id)
  end

  def friend?(user)
    Friendship.find_by_user_id_and_friend_id(self.id, user.id).nil? || Friendship.find_by_user_id_and_friend_id(user.id, self.id).nil?
  end



  def self.friendships_hash(users,friendships)
    result = nil
    if friendships.count != 0
      result = users.inject(Hash.new) { |hash,element|
        hash[element.id] = friendships.detect{|e| e.friend_id == element.id or e.user_id == element.id}
        hash
      }
    end
    result
  end

  def random_friends
    all_friends.shuffle.first(4)
  end

  def full_name
    "#{self.name} #{self.surname}"
  end

  def posts
    Post.find_user_posts(self)
  end

  def get_status(user)
    if status.nil? or status.empty?
      self.id != user.id ? "" : "Click here to change your status"
    else
      status
    end
  end

  def requests_num
    friendship_requests.count
  end

  def all_friends
    friends + inverse_friends
  end

  def all_friendships
    fr_indirect = inverse_friendships
    fr_indirect.each do |t|
      t.user_id, t.friend_id = t.friend_id, t.user_id
    end
    friendships + fr_indirect
  end

  def friendships_array
    Friendship.where("user_id = ? or friend_id = ?",id,id)
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  
  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.status} + 
                    inverse_friendships.map{|friendship| friendship.user if friendship.status}
    friends_array.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.status || friendship.nil?}.compact
  end

  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.status || friendship.nil?}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = true
    friendship.save
  end

  def reject_request(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def mutual_friends(user)
     friends & user.friends
  end

  def friends_ids
    f_ids = friends.map{|friend| friend.id } 
    f_ids << self.id
  end

end

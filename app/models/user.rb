class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :confirmed_friendships, -> { where status: true }, class_name: "Friendship"
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where status: false }, class_name: "Friendship", foreign_key: "user_id"
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverted_friendships, -> { where confirmed: false }, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friend_requests, through: :inverted_friendships

  # def friends
  #   friends_array = friendships.map { |friendship| friendship.friend if friendship.status } +
  #                   inverse_friendships.map { |friendship| friendship.user if friendship.status }
  #   friends_array.compact
  # end

  # def pending_friends
  #   friendships.map { |friendship| friendship.friend if !friendship.status || friendship.nil? }.compact
  # end

  # def friend_requests
  #   inverse_friendships.map { |friendship| friendship.user if !friendship.status || friendship.nil? }.compact
  # end

  # def confirm_friend(user)
  #   friendship = inverse_friendships.find { |f| f.user == user }
  #   friendship.status = true
  #   friendship.save
  # end

  def confirm_friend
    self.update_attributes(status: true)
    Friendship.create!(friend_id: self.user_id,
                    user_id: self.friend_id,
                    status: true)
  end

  

  def reject_request(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def mutual_friends(user)
    friends & user.friends
  end

  def friends_ids
    f_ids = friends.map(&:id)
    f_ids << id
  end
end

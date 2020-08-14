require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures name of user is present' do
      user = User.new(email: 'user@gmail.com', password: 'password').save
      expect(user).to eq(false)
    end

    it 'ensures minimum length for name to be 3' do
      user = User.new(name: 'Us', email: 'user@gmail.com', password: 'password').save
      expect(user).to eq(false)
    end

    it 'ensures max length for name to be 3' do
      user = User.new(name: 'Uduak Essien Somoye Ayotunde', email: 'user@gmail.com', password: 'password').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(name: 'User1', email: 'user@gmail.com', password: 'password').save
      expect(user) == true
    end
  end

  context 'helper methods test' do
    before(:each) do
      @user1 = User.create(name: 'User1', email: 'user1@gmail.com', password: 'password')
      @user2 = User.create(name: 'User2', email: 'user2@gmail.com', password: 'password')
      @user3 = User.create(name: 'User3', email: 'user3@gmail.com', password: 'password')
      @user4 = User.create(name: 'User4', email: 'user4@gmail.com', password: 'password')
    end

    it 'should return empty friends' do
      expect(User.first.friends.empty?).to eq(true)
    end

    it 'should return one incoming friend request' do
      User.first.friendships.new(friend_id: @user2.id, status: false).save
      expect(@user2.friend_requests.length).to eq(1)
    end

    it 'should return one pending friend request' do
      User.first.friendships.new(friend_id: @user2.id, status: false).save
      expect(@user1.pending_friends.length).to eq(1)
    end

    it 'should confirm the incoming friend request' do
      User.first.friendships.new(friend_id: @user2.id, status: false).save
      @user2.confirm_friend(@user1)
      expect(@user1.friendships.first.status).to eq(true)
    end

    it 'should reject the incoming friend request' do
      @user3.friendships.new(friend_id: @user4.id, status: false).save
      @user4.reject_request(@user3)
      expect(@user3.friendships.size).to eq(0)
    end

    it 'should affirm another user as a friend' do
      @user3.friendships.new(friend_id: @user4.id, status: false).save
      @user4.confirm_friend(@user3)
      expect(@user3.friend?(@user4)).to eq(true)
    end
  end
end

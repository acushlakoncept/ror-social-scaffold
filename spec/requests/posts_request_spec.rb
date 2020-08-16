require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET #index' do
    before { get posts_path }

    it { should redirect_to(new_user_session_path) }
  end

  describe 'Authenticated Users Activities' do
    before do
      @user = User.create(name: 'User1', email: 'user1@gmail.com', password: 'password')
      sign_in @user
    end

    it 'should successfully access post timeline' do
      get posts_path
      assert_response :success
    end

    it 'should be able to create a post' do
      @post = @user.posts.new(content: 'test post').save

      expect(@post).to eq(true)
    end
  end
end

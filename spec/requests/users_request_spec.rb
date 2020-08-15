require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers

  it 'should redirect if not logged in ' do
    get users_path
    assert_response :redirect
  end

  it 'should successfully authenticate user' do
    @user = User.create(name: 'User1', email: 'user1@gmail.com', password: 'password')
    sign_in @user
    get users_path
    assert_response :success
  end
end

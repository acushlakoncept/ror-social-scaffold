require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do

    it 'ensures name of user is present' do
      user = User.new(email: 'user@gmail.com', password: 'password').save
      expect(user).to eq(false)
    end


    it 'should save successfully' do
      user = User.new(name: 'User1', email: 'user@gmail.com', password: 'password').save
      expect(user).to eq(true)
    end

  end
end

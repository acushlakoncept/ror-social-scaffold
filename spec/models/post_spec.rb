require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation test' do
    it 'ensures content of post is present' do
      post1 = Post.new(user_id: 1)
      expect(post1.save).to eq(false)
    end

    it 'should save successfully' do
      post1 = Post.new(content: 'Test content', user_id: 1).save
      expect(post1) == true
    end
  end
end

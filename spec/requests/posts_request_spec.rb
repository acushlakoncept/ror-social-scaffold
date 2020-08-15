require 'rails_helper'

RSpec.describe "Posts", type: :request do

    describe 'GET #index' do
        before { get posts_path }
    
        it { should redirect_to(new_user_session_path) }
      end

end

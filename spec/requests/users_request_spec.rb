require 'rails_helper'

RSpec.describe "Users", type: :request do
    it 'redirected if not logged in ' do
        get users_path
        assert_response :redirect
    end
end

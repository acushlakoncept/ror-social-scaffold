class UsersController < ApplicationController

  before_action :authenticate_user!



  def index

    @users = User.where.not(email: current_user.email)

  end



  def show

    @user = User.find(params[:id])

    @posts = @user.posts.ordered_by_most_recent

  end

end


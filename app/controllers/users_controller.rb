class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @friends = @user.friends.paginate(page: params[:friends_page],
                                     per_page: 10)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

end

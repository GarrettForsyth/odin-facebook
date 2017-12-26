class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @friends = @user.friends.paginate(page: params[:friends_page],
                                     per_page: 10)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = current_user
  end

  def update_avatar
    @user = current_user
    if @user.update(user_params)
      redirect_back fallback_location: profile_path
      flash[:success] = "Avatar updated!"
    else
      flash[:error] =  "Could not update avatar."
      redirect_to edit_profile_path
    end
  end

  def delete_avatar
    @user = current_user
    @user.avatar=nil
    if @user.save
      redirect_back fallback_location: profile_path
      flash[:success]= "Avatar deleted. Now using Gravatar."
    else
      flash[:error] =  "Could not delete avatar."
    end
  end

private

  def user_params
    params.require(:user).permit(:avatar)
  end

end

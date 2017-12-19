class ProfilesController < ApplicationController

  before_action :redirect_visitors

  def show
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def edit
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.update_attributes(profile_params) 
      flash[:success] = "Profile updated!"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

private

  def redirect_visitors
    @profile = Profile.find_by(user_id: current_user.id)
    redirect_to @profile.user unless current_user == @profile.user 
  end

  def profile_params
    params.require(:profile).permit(:address,
                                    :phone,
                                    :about_me)
  end

end

class NotificationsController < ApplicationController

  def destroy
    Notification.find(params[:id]).destroy
    redirect_back(fallback_location: profile_path)
  end

  def index
    @user_notifications = Notification.where(
      user_id: current_user.id).
      order(created_at: :desc)
    @user_notifications.each do |n|
      n.update_attributes(read: :true)
    end
  end

end

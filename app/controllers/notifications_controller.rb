class NotificationsController < ApplicationController

  def destroy
    Notification.find(params[:id]).destroy
    redirect_back(fallback_location: profile_path)
  end

  def index
    @notifications = Notification.where(
      user_id: current_user.id).
      order(created_at: :desc)
    @notifications.each do |n|
      n.update_attributes(read: :true)
    end
    @notifications = @notifications.paginate(page: params[:page])
  end
end

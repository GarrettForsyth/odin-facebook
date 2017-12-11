class NotificationsController < ApplicationController

  def destroy
    Notification.find(params[:id]).destroy
  end
end

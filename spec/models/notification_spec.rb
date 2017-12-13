require 'rails_helper'

describe Notification, type: :model do

  let(:notification) { build :notification }

  it "has a valid factory" do
    expect(notification).to be_valid
  end

  it "should belong to a user" do
    notification.user_id = nil
    expect(notification).not_to be_valid
  end

  it "should be sent by another user" do
    notification.notified_by_id = nil
    expect(notification).not_to be_valid
  end

end

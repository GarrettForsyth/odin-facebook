require 'rails_helper'

describe "UserProfilePages", type: :request do

  context "the layout of a user's profile" do

    let(:user) { create :user }
    let(:user2) { create :user }

    it "allows the user to visit their own profile" do
      log_in user
      expect(current_path).to eq(profile_path)
    end

  end
end

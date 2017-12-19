require 'rails_helper'

describe Profile, type: :model do
  
  let(:profile) { create :profile }

  it "has a valid factory" do
    expect(profile).to be_valid
  end

  it "is invalid without a user" do
    profile.user = nil
    expect(profile).not_to be_valid
  end

end

require 'rails_helper'

describe Friendship, type: :model do

  let(:friendship) { FactoryBot.build(:friendship) }

  it "has a valid factory." do
    expect(friendship).to be_valid
  end

  it "doesn't allow self friendships" do
    user = create :user
    friendship.user = user
    friendship.friend = user
    expect(friendship).not_to be_valid
  end
                                             
  it "does not allow duplicate friendships." do
    dup = friendship
    friendship.save!
    expect(dup).not_to be_valid
  end



  
end

require 'rails_helper'

describe Comment, type: :model do

  let(:comment) { build :comment }

  it "has a valid factory" do
    expect(comment).to be_valid
  end

  it "does not have blank content" do
    comment.content = "         "
    expect(comment).not_to be_valid
  end

  it "belongs to a post" do
    comment.post_id = nil
    expect(comment).not_to be_valid
  end

  it "belongs to an author" do
    comment.author_id = nil
    expect(comment).not_to be_valid
  end

  it "has content no longer than 1000 characters" do
    comment.content = "a"*1001
    expect(comment).not_to be_valid
  end

end

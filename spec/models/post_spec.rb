require 'rails_helper'

describe Post, type: :model do

 let(:post) { build :post } 

 it "has a valid factory" do
   expect(post).to be_valid
 end

 it "has an author id" do
   post.author_id = nil
   expect(post).not_to be_valid
 end

 it "it's content is not blank" do
   post.content = "          " 
   expect(post).not_to be_valid
 end

 it "its content not longer than 1000 characters" do
   post.content = "a"* 1001
   expect(post).not_to be_valid
 end

end

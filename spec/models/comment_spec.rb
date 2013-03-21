# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :string(255)
#  rating     :integer
#  is_about   :integer
#  user_id    :integer
#

require 'spec_helper'

describe Comment do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @comment = user.comments.build(text: "This is a simple comment", rating: 3, is_about: 1) }
  
  subject{ @comment }
  
  it { should respond_to(:text) }
  it { should respond_to(:rating) }
  it { should respond_to(:is_about) }
  
  describe "properties of text" do
    describe "should not be valid without a text" do
      before { @comment.text = nil }
      it { should_not be_valid }
    end
    
    describe "shouldn't exceed 140 characters" do
      before { @comment.text = "a" * 150 }
      it { should_not be_valid }
    end
  end

  describe "properties of rating" do
    describe "should not be valid without a rating" do
      before { @comment.rating = nil }
      it { should_not be_valid }    
    end
    
    describe "can be 5" do
      before { @comment.rating = 5 }
      it { should be_valid }
    end
    
    describe "can be 0" do
      before { @comment.rating = 0 }
      it { should be_valid }
    end
    
    describe "shouldn't exceed 5" do
      before { @comment.rating = 6 }
      it { should_not be_valid }
    end
    
    describe "shouldn't be below 0" do
      before { @comment.rating = -1 }
      it { should_not be_valid }      
    end
    
    describe "should be an integer" do
      before { @comment.rating = 4.1 }
      it { should_not be_valid }
    end
  end
  
  describe "properties of is_about" do
    describe "should not be valid without is_about" do
      before { @comment.is_about = nil }
      it { should_not be_valid }
    end
    
    describe "should be an integer" do
      before { @comment.is_about = 1.2 }
      it { should_not be_valid }  
    end
    
    describe "should be a valid user_id with at least 1 posting" do
      before { @comment.is_about = 123849718237649172634 }
      it { should_not be_valid }
    end
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Comment.new(user_id: user.id)        
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
end

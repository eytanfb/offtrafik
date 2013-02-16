require 'spec_helper'

describe Posting do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @posting = user.postings.build(from_address: "Ortakoy, Istanbul", to_address: "Koc University", price: 5, 
    date: '07/11/2011', starting_time: "#{Time.now}", ending_time: "#{Time.now + 1.hour}" ) }

  subject { @posting }
  
  it { should respond_to(:from_address) }
  it { should respond_to(:to_address) }
  it { should respond_to(:date) }
  it { should respond_to(:starting_time) }
  it { should respond_to(:ending_time) }
  it { should respond_to(:price) }

  describe "if it doesn't have an owner it should not be valid" do
    before { @posting.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "if it doesn't have a from_address it should not be valid" do
    before { @posting.from_address = nil }
    it { should_not be_valid }
  end
  
  describe "if it doesn't have a to_address it should not be valid" do
    before { @posting.to_address = nil }
    it { should_not be_valid }
  end
  
  describe "if it doesn't have a price it should not be valid" do
    before { @posting.price = nil }
    it { should_not be_valid }
  end
  
  describe "if it doesn't have a starting_time it should not be valid" do
    before { @posting.starting_time = nil }
    it { should_not be_valid }
  end
  
  describe "if it doesn't have a ending_time it should not be valid" do
    before { @posting.ending_time = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Posting.new(user_id: user.id)        
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end

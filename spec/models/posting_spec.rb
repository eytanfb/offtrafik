# == Schema Information
#
# Table name: postings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  date          :date
#  starting_time :time
#  ending_time   :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comments      :text
#  smoking       :boolean
#  driving       :string(255)
#  from_address  :string(255)
#  to_address    :string(255)
#

require 'spec_helper'

describe Posting do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @posting = user.postings.build(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: '07-11-2011', starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu" ) }

  subject { @posting }
  
  it { should respond_to(:from_address) }
  it { should respond_to(:to_address) }
  it { should respond_to(:date) }
  it { should respond_to(:starting_time) }
  it { should respond_to(:ending_time) }
  it { should respond_to(:comments) }
  it { should respond_to(:smoking)}
  it { should respond_to(:driving)}
  it { should have_many(:posting_responses).dependent(:destroy) }
  it { should belong_to(:user) }

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
  
  describe "if it doesn't have a starting_time it should not be valid" do
    before do
      @posting.starting_time = nil
    end
    it { should_not be_valid }
  end
  
  describe "if it doesn't have a ending_time it should not be valid" do
    before do
      @posting.ending_time = nil
    end
    it { should_not be_valid }
  end
  
  describe "if starting_time is later than ending_time it should not be valid" do
    before do
      @posting.ending_time = Time.now
      @posting.starting_time = Time.now + 1.hour
    end
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

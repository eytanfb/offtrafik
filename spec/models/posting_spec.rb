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
  
  let(:user) { create(:user) }
  let(:user_2) { create(:user, first_name: "Another") }
  before { @posting = user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
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
  it { should respond_to(:people_who_completed_journey) }
  it { should have_many(:posting_responses).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:from_address) }
  it { should validate_presence_of(:to_address) }
  it { should validate_presence_of(:starting_time) }
  it { should validate_presence_of(:ending_time) }
    
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
  
  describe ".people_who_completed_journey", :focus do
    it "should return 0 if there are no responses" do
      @posting.people_who_completed_journey(user.name).count.should == 0
    end
    it "should return an array all the people who have been accepted to the posting and if both parties agreed" do
      3.times do |n|
        response = @posting.posting_responses.create!(responder_id: user_2.id, accepted: true)
        response.update_attribute(:poster_agreed, true) if n.even?
        response.update_attribute(:responder_agreed, true)
      end
      @posting.people_who_completed_journey(user.name).count.should == 2
      @posting.people_who_completed_journey(user.name).first.should == user_2.name
      @posting.people_who_completed_journey(user.name).last.should == user_2.name
      @posting.people_who_completed_journey(user.name).include?(user.name).should == false
      user_2.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: '07-11-2011', starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu" )
      user_2.postings.first.posting_responses.create!(responder_id: user.id, accepted: true)
      user_2.postings.first.posting_responses.first.update_attribute(:poster_agreed, true)
      user_2.postings.first.posting_responses.first.update_attribute(:responder_agreed, true)
      user_2.postings.first.people_who_completed_journey(user.name).count == 1
      user_2.postings.first.people_who_completed_journey(user.name).first.should == user_2.name
      user_2.postings.first.people_who_completed_journey(user.name).include?(user.name).should == false
    end
  end
  
end

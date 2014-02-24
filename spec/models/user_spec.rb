# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string(255)      default(""), not null
#  encrypted_password             :string(255)      default(""), not null
#  reset_password_token           :string(255)
#  reset_password_sent_at         :datetime
#  remember_created_at            :datetime
#  sign_in_count                  :integer          default(0), not null
#  current_sign_in_at             :datetime
#  last_sign_in_at                :datetime
#  current_sign_in_ip             :string(255)
#  last_sign_in_ip                :string(255)
#  agreed_to_terms_and_conditions :boolean
#  trip_rating                    :integer
#  summary                        :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  neighborhood                   :string(255)
#  confirmation_token             :string(255)
#  confirmed_at                   :datetime
#  confirmation_sent_at           :datetime
#  first_name                     :string(255)
#  last_name                      :string(255)
#  unconfirmed_email              :string(255)
#  phone                          :string(255)
#  driver                         :boolean
#  avatar_file_name               :string(255)
#  avatar_content_type            :string(255)
#  avatar_file_size               :integer
#  avatar_updated_at              :datetime
#

require 'spec_helper'

describe User do
  
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  
  it { should respond_to(:email) }
  it { should respond_to(:trip_rating) }
  it { should respond_to(:summary) }
  it { should respond_to(:neighborhood) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:name) }
  it { should respond_to(:agreed_to_terms_and_conditions) }
  it { should respond_to(:has_past_responses?) }
  it { should respond_to(:has_past_postings?) }
  it { should respond_to(:has_showable_journeys?) }
  it { should respond_to(:unagreed_postings) }
  it { should respond_to(:total_journeys) }
  it { should respond_to(:agreed_journeys) }
  it { should respond_to(:phone) }
  it { should have_many(:postings) }
  it { should have_many(:posting_responses) }
  it { should have_many(:favorites) }
  it { should have_many(:comments) }
  it { should have_many(:frequent_postings) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
  it { should ensure_inclusion_of(:agreed_to_terms_and_conditions).in_array([true]) }
  it { should ensure_length_of(:password).is_at_least(6).is_at_most(20) }
  it { should allow_value("abs@ku.edu.tr").for(:email) }
  it { should allow_value("abs@alumni.ku.edu.tr").for(:email) }
  it { should_not allow_value("abs@asd.ku.edu.tr").for(:email) }
  
  describe ".has_past_postings?" do
    it "should return false if user has no past posting" do
      user.has_past_postings?.should == false
    end
    
    it "should return false if there are past postings but no posting responses" do
      user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      user.has_past_postings?.should == false
    end
    
    it "should return true if user has past postings and postings have posting responses and posting responses are accepted and poster_agreed.nil?" do
      user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      user.postings.first.posting_responses.create!(responder_id: 3)
      user.has_past_postings?.should == false
      user.postings.first.posting_responses.first.update_attribute(:accepted, false)
      user.has_past_postings?.should == false
      user.postings.first.posting_responses.first.update_attribute(:accepted, true)
      user.postings.first.posting_responses.first.update_attribute(:poster_agreed, false)
      user.has_past_postings?.should == false
      user.postings.first.posting_responses.first.update_attribute(:poster_agreed, nil)
      user.has_past_postings?.should == true
    end
  end
  
  describe ".has_past_responses?" do
    it "should return false if user has not responded to any postings that has passed" do
      user.posting_responses.first.should be_nil
      user.posting_responses.empty?.should == true
      user.has_past_responses?.should == false
    end

    it "should return false if user has responded to a posting that has passed but posting_response is nil or not accepted" do
      user_2.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      user_2.postings.first.posting_responses.create!(responder_id: user.id)
      user_2.postings.first.posting_responses.first.accepted.should be_nil
      user.has_past_responses?.should == false
      user_2.postings.first.posting_responses.first.update_attribute(:accepted, false)
      user_2.postings.first.posting_responses.first.accepted.should == false
      user.has_past_responses?.should == false
    end

    it "should return false if response.accepted but !responder_agreed.nil?" do
      user_2.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      user_2.postings.first.posting_responses.create!(responder_id: user.id, accepted: true)
      user.has_past_responses?.should == true
      user_2.postings.first.posting_responses.first.update_attribute(:responder_agreed, true)
      user.has_past_responses?.should == false
    end

    it "should return true if response.accepted and responder_agreed.nil?" do
      user_2.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      user_2.postings.first.posting_responses.create!(responder_id: user.id, accepted: true)
      user.has_past_responses?.should == true
    end
  end
  
  describe ".total_journeys" do
    it "should return the number of past postings + accepted and agreed responses" do
      user.total_journeys.should == 0
      5.times do
        user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
      date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      end
      user.total_journeys.should == 5
      user_2.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
      date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
      user_2.postings.first.posting_responses.create!(responder_id: user.id, accepted: true)
      user_2.postings.first.posting_responses.first.update_attribute(:responder_agreed, true)
      user.total_journeys.should == 6
    end
  end
  
  it ".agreed_journeys should return all journeys in postings and posting_response.accepted and !response.responder_agreed.nil?" do
    user.agreed_journeys.should be_empty
    5.times do
      user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
    end
    user.agreed_journeys.count == 5
    user_2.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
    date: 1.week.ago, starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu")
    user_2.postings.first.posting_responses.create!(responder_id: user.id, accepted: true)
    user_2.postings.first.posting_responses.first.update_attribute(:responder_agreed, true)
    user.agreed_journeys.count.should == 6
  end
end

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
#

require 'spec_helper'

describe User do
  
  let(:user) { create(:user) }
  
  it { should respond_to(:email) }
  it { should respond_to(:trip_rating) }
  it { should respond_to(:summary) }
  it { should respond_to(:neighborhood) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:name) }
  it { should respond_to(:agreed_to_terms_and_conditions) }
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
  
  it "has_past_responses should be false if there is no response for which the posting.date < Date.today" do  
    user.has_past_responses?.should == false
  end
  
  # create a past response
  describe "has_past_responses should be true if there is a response for which the posting.date < Date.today" do
    let(:posting) { create(:posting, date: 1.week.ago, user_id: user.id) }
    before { posting.posting_responses.create!(responder_id: (user.id)+1) }
    it { user.has_past_responses?.should == true }
  end
  
  describe "has_past_responses should also return true if user has responded to other postings" do
    let(:user2) { create(:user) }
    before do
      user2.postings.create!(date: 1.week.ago, to_address: "asdf", from_address: "adsf", starting_time: Time.now, ending_time: Time.now+30.minutes, driving: "Yolcu")
      user2.postings.first.posting_responses.create!(responder_id: user.id)
    end
    it "should return true if posting_responses are not answered" do
      user2.postings.first.date.should < Date.today
      user.postings.empty?.should == true
      user.posting_responses.empty?.should == false
      user2.postings.first.posting_responses.first.responder_id.should == user.id
      user.has_past_responses?.should == true
    end
    it "should return false if all posting answers are answered", :focus do
      user2.postings.first.posting_responses.first.update_attribute(:responder_agreed, true)
      user2.postings.first.posting_responses.first.responder_agreed.should == true
      user.has_past_responses?.should == false
    end
  end
end
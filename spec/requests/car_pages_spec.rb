require 'spec_helper'

describe "CarPages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  # describe "car creation" do
    # before { visit root_path }
#     
    # describe "with invalid information" do
#       
      # it "should not create a car" do
        # expect { click_button "Kaydet" }.not_to change(Car, :count)
      # end
#       
      # describe "error messages" do
        # before { click_button "Kaydet" }
        # it { should have_content('error') }
      # end
    # end
#     
    # describe "with valid information" do
      # before do  
        # fill_in 'Capacity', with: "4"
        # fill_in 'Smoking', with: false
      # end
      # it "should create a car" do
        # expect { click_button "Kaydet" }.to change(Car, :count).by(1)
      # end
    # end
  # end
end

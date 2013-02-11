# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  driver_rating   :integer
#  person_rating   :integer
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: 'Example User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar', 
    driver_rating: 5, person_rating: 5) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:cars) }
  it { should respond_to(:driver_rating) }
  it { should respond_to(:person_rating) }
  
  it { should be_valid }
  it { should_not be_admin }
  
  describe "with admin attribute set to true" do
    before do
      @user.save!
      @user.toggle!(:admin) # flips the given attribute from one state to the other. in this case false => true
    end
    
    it { should be_admin }
  end
  
  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email is not a valid format" do
    it "should not be valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email is  a valid format" do
    it "should  be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "email has to be unique" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }    
  end
  
  describe "when password is empty" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "not foobar" }
    it { should_not be_valid }
  end
  
  describe "when password_confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not == user_for_invalid_password }
      specify {user_for_invalid_password.should be_false }
    end    
  end
  
  describe "password too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }    
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "driver rating can't be more than 5" do
    before { @user.driver_rating = 6 }
    it { should_not be_valid }
  end
  
  describe "person rating can't be more than 5" do
    before { @user.person_rating = 6 }
    it { should_not be_valid }
  end
  
end

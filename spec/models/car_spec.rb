require 'spec_helper'

describe Car do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @car = user.cars.build(capacity: 4, smoking: false) }
  
  subject { @car }
  
  it { should respond_to(:capacity) }
  it { should respond_to(:smoking) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @car.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Car.new(user_id: user.id)        
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "car capacity should not exceed 4" do
    before { @car.capacity = 5 }
    it { should_not be_valid }
  end
end

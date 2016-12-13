require 'rails_helper'

RSpec.describe User, type: :model do
  context "Factory building and creation" do

    it "should be able to build a factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "should be able to create a factory" do
      expect(FactoryGirl.create(:user)).to be_valid
    end

  end
end

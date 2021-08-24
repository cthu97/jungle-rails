require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is valid with matching user and pw" do
      @user = User.new(name: "tester", email: "test@test.com", password: "fiveletters", password_confirmation: "fiveletters")

      expect(@user).to be_valid
    end

    it "is not valid if pw and pw confirmation do not match" do
      @user = User.new(name: "tester", email: "test@test.com", password: "fiveletters", password_confirmation: "sixletters")

      expect(@user).to_not be_valid
    end 

    it "is not valid if email is not unique" do
      @user = User.new(name: "tester", email: "test@test.com", password: "fiveletters", password_confirmation: "fiveletters")
      @user2 = User.new(name: "tester2", email: "TEST@TEST.com", password: "sixletters", password_confirmation: "sixletters")
      
      @user.save!
      expect(@user).to be_valid
      expect(@user2).to_not be_valid
    end

    it "not valid without email, first name" do
      @user = User.new(email: "test@test.com", password: "fiveletters", password_confirmation: "fiveletters")
      @user2 = User.new(name: "tester", password: "fiveletters", password_confirmation: "fiveletters")

      expect(@user).to_not be_valid
      expect(@user2).to_not be_valid
    end

    it "is not valid if password length shorter than required" do
      @user = User.new(name: "tester", password: "1", password_confirmation: "1")

      expect(@user).to_not be_valid
    end
  end
end
    describe '.authenticate_with_credentials' do
      it 'can login with registered email and password' do
        @user = User.create(name: "tester", email: "test@test.com", password:"fiveletters", password_confirmation:"fiveletters")
        expect(User.authenticate_with_credentials("test@test.com", "fiveletters")).to eq(@user)
      end
end
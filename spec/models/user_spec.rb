require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it 'must contains password' do
      user = User.new(name:'ray' , email:'123@test.com', password: nil, password_confirmation: 'hello')
      user.save
      expect(user.errors[:password]).to_not be_empty
      expect(user).to_not be_valid
    end
    it 'must contains password_confirmation' do
      user = User.new(name:'ray' , email:'123@test.com', password: 'hello', password_confirmation: nil)
      user.save
      expect(user.errors[:password_confirmation]).to_not be_empty
      expect(user).to_not be_valid
    end
    it 'should failed if password and password_confirmation does not match' do
      user = User.new(name:'ray' , email:'123@test.com', password: 'hello', password_confirmation: 'bonjour')
      user.save
      expect(user).to_not be_valid
    end
    it 'should passed if password and password_confirmation does match' do
      user = User.new(name:'ray' , email:'123@test.com', password: 'helloss', password_confirmation: 'helloss')
      user.save
      expect(user).to be_valid
    end
    it 'should display error when saving a user with the same password (exact match) into database' do
      userA = User.new(name:'ray' , email:'abc@test.com', password: 'helloss', password_confirmation: 'helloss')
      userA.save
      userB = User.new(name:'ray' , email:'abc@test.com', password: 'helloss', password_confirmation: 'helloss')
      userB.save
      expect(userB.errors[:email]).to_not be_empty
      expect(userB).to_not be_valid
    end

    it 'should display error when saving a user with the same password (uppercase) into database' do
      userA = User.new(name:'ray' , email:'abc@test.com', password: 'helloss', password_confirmation: 'helloss')
      userA.save
      userB = User.new(name:'ray' , email:'ABC@TEST.COM', password: 'helloss', password_confirmation: 'helloss')
      userB.save
      expect(userB.errors[:email]).to_not be_empty
      expect(userB).to_not be_valid
    end
    
    it 'should be a valid email' do
      user = User.new(name:'hello' , email:nil, password: 'helloss', password_confirmation: 'helloss')
      user.save
      expect(user.errors[:email]).to_not be_empty
      expect(user).to_not be_valid
    end

    it 'should be a valid name' do
      user = User.new(name:nil , email:'123@test.com', password: 'helloss', password_confirmation: 'helloss')
      user.save
      expect(user.errors[:name]).to_not be_empty
      expect(user).to_not be_valid
    end

    it 'should not be valid when password is less than 6 characters' do
      user = User.new(name:nil , email:'123@test.com', password: 'hello', password_confirmation: 'hello')
      user.save
      expect(user.errors[:password]).to_not be_empty
      expect(user).to_not be_valid
    end

    describe '.authenticate_with_credentials' do
      it 'should return user if its a existing valid user' do 
        user = User.new(name:'ray' , email:'123@test.com', password: 'hello123', password_confirmation: 'hello123')
        user.save
        testingUser = User.authenticate_with_credentials('123@test.com', user.password)
        expect(testingUser.password_digest).to_not be_empty
      end
      it 'should return user if user enters extra spaces in email when logging in ' do 
        user = User.new(name:'ray' , email:'123@test.com', password: 'hello123', password_confirmation: 'hello123')
        user.save
        testingUser = User.authenticate_with_credentials('  123@test.com', user.password)
        expect(testingUser.password_digest).to_not be_empty
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'pass with all fields present' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test').save
      expect(user).to eq(true)
    end
    it 'fail when name is missing' do 
      user = User.new(name: nil, email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user.validate
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it 'fail when password is missing' do 
      user = User.new(name: 'test', email: 'test@test.com', password: nil, password_confirmation: 'test')
      user.validate
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'fail when password and password_confirmation do not match' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'tester')
      user.validate
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'fail when password length is less than 4' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'tes', password_confirmation: 'tes')
      user.validate
      expect(user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
    it 'fail when password length is greater than 16' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'qqqqwwwweeeerrrrt', password_confirmation: 'qqqqwwwweeeerrrrt')
      user.validate
      expect(user.errors.full_messages).to include("Password is too long (maximum is 16 characters)")
    end
    it 'fail when email is missing' do
      user = User.new(name: 'test', email: nil, password: 'test', password_confirmation: 'test')
      user.validate
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'fail when email is not unique' do
      User.create(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user = User.new(name: 'test', email: 'Test@test.com', password: 'test', password_confirmation: 'test')
      user.validate
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns instance of user if email and password match user in database' do
      User.create(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user = User.authenticate_with_credentials('test@test.com', 'test')
      expect(user).to be_a_kind_of(User)
    end
    it 'returns nil no user found with matching email' do
      User.create(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user = User.authenticate_with_credentials('test@test.co', 'test')
      expect(user).to be_nil
    end
    it 'returns nil if user is found with matching email but password does not match' do
      User.create(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user = User.authenticate_with_credentials('test@test.com', 'tes')
      expect(user).to be_nil
    end
    it 'returns instance of user if there is extra whitespace surrounding correct email' do
      User.create(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user = User.authenticate_with_credentials('   test@test.com ', 'test')
      expect(user).to be_a_kind_of(User)
    end
    it 'returns instance of user if the password is correct but of different case' do
      User.create(name: 'test', email: '  Test@test.com', password: 'test', password_confirmation: 'test')
      user = User.authenticate_with_credentials('teST@test.com   ', 'test')
      expect(user).to be_a_kind_of(User)
    end
  end
end

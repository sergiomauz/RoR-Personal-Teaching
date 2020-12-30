require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    FactoryBot.create(:user,
                      username: 'goku',
                      password: '123456',
                      fullname: 'Son Goku',
                      email: 'goku@dragonball.xyz',
                      admin: true)
    FactoryBot.create(:user,
                      username: 'gohan',
                      password: '123456',
                      fullname: 'Son Gohan',
                      email: 'gohan@dragonball.xyz')
  end

  describe 'Tests for USER model' do
    let(:user_one) { User.first }
    let(:user_two) { User.last }

    it 'Valid full User' do
      @user_three = User.new(
        {
          username: 'goten',
          password: '123456',
          fullname: 'Son Goten',
          email: 'goten@dragonball.xyz',
          admin: false
        }
      )

      expect(@user_three).to be_valid
    end

    it 'Valid full User 2 times, second go fails' do
      @user_three = User.new(
        {
          username: 'goku',
          password: '123456',
          fullname: 'Son Goku',
          email: 'goku@dragonball.xyz',
          admin: true
        }
      )

      expect(@user_three).to_not be_valid
    end

    it 'Valid User, is not Admin by default' do
      @user_three = User.new(
        {
          username: 'goku',
          password: '123456',
          fullname: 'Son Goku',
          email: 'goku@dragonball.xyz'
        }
      )

      expect(@user_three.admin).to be false
    end

    it 'User without password' do
      @user_two = User.new(
        {
          username: 'goku',
          fullname: 'Son Goku',
          email: 'goku@dragonball.xyz'
        }
      )

      expect(@user_two).to_not be_valid
    end

    it 'User with no valid email' do
      @user_two = User.new(
        {
          username: 'goku',
          password: '123456',
          fullname: 'Son Goku',
          email: 'songokudbz'
        }
      )

      expect(@user_two).to_not be_valid
    end
  end
end

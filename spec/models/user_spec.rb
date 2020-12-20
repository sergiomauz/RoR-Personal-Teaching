require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Tests for USER model' do
    it 'Valid full User' do
      @user = User.new({
                         username: 'goku',
                         password: '123456',
                         fullname: 'Son Goku',
                         email: 'goku@dragonball.xyz',
                         admin: true
                       })
      @user.save

      expect(@user).to be_valid
      expect(User.last).to be_valid
    end

    it 'Valid full User 2 times, second go fails' do
      @user1 = User.new({
                          username: 'goku',
                          password: '123456',
                          fullname: 'Son Goku',
                          email: 'goku@dragonball.xyz',
                          admin: true
                        })
      @user1.save

      expect(@user1).to be_valid
      expect(User.last).to be_valid

      @user2 = User.new({
                          username: 'goku',
                          password: '123456',
                          fullname: 'Son Goku',
                          email: 'goku@dragonball.xyz',
                          admin: true
                        })
      @user2.save

      expect(@user2).to_not be_valid
    end

    it 'Valid User, is not Admin by default' do
      @user = User.new({
                         username: 'goku',
                         password: '123456',
                         fullname: 'Son Goku',
                         email: 'goku@dragonball.xyz'
                       })
      @user.save

      expect(@user.admin).to be false
      expect(User.last.admin).to be false
    end

    it 'User without password' do
      @user = User.new({
                         username: 'goku',
                         fullname: 'Son Goku',
                         email: 'goku@dragonball.xyz'
                       })
      @user.save

      expect(@user).to_not be_valid
      expect(User.last).to be nil
    end

    it 'User with no valid email' do
      @user = User.new({
                         username: 'goku',
                         password: '123456',
                         fullname: 'Son Goku',
                         email: 'songokudbz'
                       })
      @user.save

      expect(@user).to_not be_valid
      expect(User.last).to be nil
    end
  end
end

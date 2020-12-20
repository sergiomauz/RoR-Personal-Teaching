require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'Tests for APPOINTMENT model' do
    it 'Valid full Appointment' do
      @user = User.new({
                         username: 'gohan',
                         password: '123456',
                         fullname: 'Son Gohan',
                         email: 'gohan@dragonball.xyz',
                         admin: true
                       })
      @user.save
      expect(@user).to be_valid

      @teacher = Teacher.new({
                               fullname: 'Son Goku',
                               email: 'goku@dragonball.xyz',
                               course: 'Martial Arts',
                               description: 'How to manage Migate no Gokui?'
                             })
      @teacher.save
      expect(@teacher).to be_valid

      @appointment = Appointment.new({
                                       user_id: User.last.id,
                                       teacher_id: Teacher.last.id,
                                       scheduled_for: Time.now.utc.next_day(3)
                                     })
      @appointment.save

      expect(@appointment).to be_valid
      expect(Appointment.last).to be_valid
    end

    it 'Appointment with no Teacher' do
      @user = User.new({
                         username: 'gohan',
                         password: '123456',
                         fullname: 'Son Gohan',
                         email: 'gohan@dragonball.xyz',
                         admin: true
                       })
      @user.save
      expect(@user).to be_valid

      @appointment = Appointment.new({
                                       user_id: User.last.id,
                                       scheduled_for: Time.now.utc.next_day(3)
                                     })
      @appointment.save

      expect(@appointment).to_not be_valid
      expect(Appointment.last).to be nil
    end

    it 'Appointment with no User, fails' do
      @teacher = Teacher.new({
                               fullname: 'Son Goku',
                               email: 'goku@dragonball.xyz',
                               course: 'Martial Arts',
                               description: 'How to manage Migate no Gokui?'
                             })
      @teacher.save
      expect(@teacher).to be_valid

      @appointment = Appointment.new({
                                       teacher_id: Teacher.last.id,
                                       scheduled_for: Time.now.utc.next_day(3)
                                     })
      @appointment.save

      expect(@appointment).to_not be_valid
      expect(Appointment.last).to be nil
    end
  end
end

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  before(:all) do
    FactoryBot.create(:user,
                      username: 'gohan',
                      password: '123456',
                      fullname: 'Son Gohan',
                      email: 'gohan@dragonball.xyz',
                      admin: true)
    FactoryBot.create(:teacher,
                      fullname: 'Son Goku',
                      email: 'goku@dragonball.xyz',
                      course: 'Martial Arts',
                      description: 'How to master Migate no Gokui?')
    FactoryBot.create(:appointment,
                      user_id: User.last.id,
                      teacher_id: Teacher.last.id,
                      scheduled_for: Time.now.utc.next_day(3))
  end

  describe 'Tests for APPOINTMENT model' do
    let(:user_one) { User.last }
    let(:teacher_one) { Teacher.last }
    let(:appointment_one) { Appointment.last }

    it 'Valid full Appointment' do
      expect(appointment_one).to be_valid
    end

    it 'Appointment with no Teacher is not valid' do
      @appointment = Appointment.new({ user_id: User.last.id, scheduled_for: Time.now.utc.next_day(3) })

      expect(@appointment).to_not be_valid
    end

    it 'Appointment with no User is not valid' do
      @appointment = Appointment.new({ teacher_id: Teacher.last.id, scheduled_for: Time.now.utc.next_day(3) })

      expect(@appointment).to_not be_valid
    end
  end
end

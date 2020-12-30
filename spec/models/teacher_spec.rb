require 'rails_helper'

RSpec.describe Teacher, type: :model do
  before(:all) do
    FactoryBot.create(:teacher,
                      fullname: 'Son Goku',
                      email: 'goku@dragonball.xyz',
                      course: 'Martial Arts',
                      description: 'How to manage Migate no Gokui?',
                      photo: 'https://localhost:8080/image.png')
  end

  describe 'Tests for TEACHER model' do
    let(:teacher_one) { Teacher.last }

    it 'Valid full Teacher' do
      expect(teacher_one).to be_valid
    end

    it 'Valid Teacher with no photo' do
      @teacher = Teacher.new(
        {
          fullname: 'Son Goku',
          email: 'goku@dragonball.xyz',
          course: 'Martial Arts',
          description: 'How to manage Migate no Gokui?'
        }
      )

      expect(@teacher).to be_valid
    end

    it 'Teacher with no valid email' do
      @teacher = Teacher.new(
        {
          fullname: 'Son Goku',
          email: 'songokuxyz',
          course: 'Martial Arts',
          description: 'How to manage Migate no Gokui?'
        }
      )

      expect(@teacher).to_not be_valid
    end

    it 'Teacher with no description' do
      @teacher = Teacher.new(
        {
          fullname: 'Son Goku',
          email: 'songokuxyz',
          course: 'Martial Arts'
        }
      )

      expect(@teacher).to_not be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'Tests for TEACHER model' do
    it 'Valid full Teacher' do
      @teacher = Teacher.new({
                               fullname: 'Son Goku',
                               email: 'goku@dragonball.xyz',
                               course: 'Martial Arts',
                               description: 'How to manage Migate no Gokui?',
                               photo: 'https://localhost:8080/image.png'
                             })
      @teacher.save

      expect(@teacher).to be_valid
      expect(Teacher.last).to be_valid
    end

    it 'Valid Teacher with no photo' do
      @teacher = Teacher.new({
                               fullname: 'Son Goku',
                               email: 'goku@dragonball.xyz',
                               course: 'Martial Arts',
                               description: 'How to manage Migate no Gokui?'
                             })
      @teacher.save

      expect(@teacher).to be_valid
      expect(Teacher.last).to be_valid
    end

    it 'User with no valid email' do
      @teacher = Teacher.new({
                               fullname: 'Son Goku',
                               email: 'songokuxyz',
                               course: 'Martial Arts',
                               description: 'How to manage Migate no Gokui?'
                             })
      @teacher.save

      expect(@teacher).to_not be_valid
      expect(Teacher.last).to be nil
    end

    it 'User with no description' do
      @teacher = Teacher.new({
                               fullname: 'Son Goku',
                               email: 'songokuxyz',
                               course: 'Martial Arts'
                             })
      @teacher.save

      expect(@teacher).to_not be_valid
      expect(Teacher.last).to be nil
    end
  end
end

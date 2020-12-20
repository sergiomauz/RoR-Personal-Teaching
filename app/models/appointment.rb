class Appointment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :teacher, class_name: 'Teacher'

  validates :user_id, null: false
  validates :teacher_id, null: false
  validates :scheduled_for, null: false
end

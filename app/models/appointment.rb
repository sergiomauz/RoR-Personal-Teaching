class Appointment < ApplicationRecord
  before_save :set_null_if_new_date_is_not_valid

  belongs_to :user, class_name: 'User'
  belongs_to :teacher, class_name: 'Teacher'

  validates :user_id, null: false
  validates :teacher_id, null: false
  validates :scheduled_for, null: false

  def set_null_if_new_date_is_not_valid
    self.scheduled_for = nil unless scheduled_for > Time.now.utc
  end

  def self.detailed_info(appointment_id)
    Appointment
      .select(:id,
              :scheduled_for,
              'teachers.fullname as teacher_fullname',
              'teachers.course',
              'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
      .joins(:teacher)
      .where(id: appointment_id)
      .first
  end
end

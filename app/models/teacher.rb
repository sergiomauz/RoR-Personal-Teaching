class Teacher < ApplicationRecord
  validates :fullname, presence: true, length: { in: 5..75 }
  validates :email, presence: true, length: { in: 5..50 }
  validates :course, presence: true, length: { in: 4..50 }
  validates :description, presence: true, length: { in: 5..150 }

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :appointments, class_name: 'Appointment'

  def appointments_scheduled    
    Appointment.select(:id,
                        :scheduled_for,
                        'users.fullname as user_fullname',
                        'users.email as user_email',
                        'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
                .joins(:user)
                .where(teacher_id: self.id)
                .order(scheduled_for: :asc)    
  end
end

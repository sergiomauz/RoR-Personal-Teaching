class Teacher < ApplicationRecord
  validates :fullname, presence: true, length: { in: 5..75 }
  validates :email, presence: true, length: { in: 5..50 }
  validates :course, presence: true, length: { in: 4..50 }
  validates :description, presence: true, length: { in: 5..150 }

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :appointments, class_name: 'Appointment'

  def appointments_scheduled
    Appointment
      .select(:id,
              :scheduled_for,
              'users.fullname as user_fullname',
              'users.email as user_email',
              'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
      .joins(:user)
      .where(teacher_id: id)
      .order(scheduled_for: :asc)
  end

  def availability(booking_date)
    if booking_date.to_date > Time.now.utc.to_date
      @availability =
        [8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19] -
        Appointment
          .where('teacher_id = ? AND scheduled_for BETWEEN ? AND ?',
                 id, booking_date.to_date, booking_date.to_date.next_day(1))
          .pluck(Arel.sql('CAST(extract(hour from scheduled_for) as INTEGER)'))

      return {
        'teacher' => {
          'id' => id,
          'availability' => @availability
        }
      }
    end

    {
      'teacher' => {
        'id' => id,
        'availability' => []
      }
    }
  end
end

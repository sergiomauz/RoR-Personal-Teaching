json.extract! appointment, :id, :appointmenttime, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)

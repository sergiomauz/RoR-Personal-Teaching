json.extract! appointment, :id, :scheduled_for, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)

json.appointments(@appointments) do |appointment|
  json.id appointment.id
  json.scheduled_for appointment.scheduled_for
  json.user_fullname appointment.user_fullname
  json.user_email appointment.user_email
  json.status appointment.status
end

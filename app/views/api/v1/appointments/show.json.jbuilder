json.appointment do
  json.id @appointment.id
  json.user_id @appointment.user_id
  json.teacher_id @appointment.teacher_id
  json.scheduled_for @appointment.scheduled_for
end

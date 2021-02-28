json.appointment do
  json.id @appointment.id
  json.scheduled_for @appointment.scheduled_for
  json.teacher_fullname @appointment.teacher_fullname
  json.course @appointment.course
  json.status @appointment.status
end

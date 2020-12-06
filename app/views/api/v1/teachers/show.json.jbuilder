json.teacher do
  json.id @teacher.id
  json.fullname @teacher.fullname
  json.email @teacher.email
  json.photo @teacher.photo
  json.description @teacher.description
  json.course @teacher.course
end

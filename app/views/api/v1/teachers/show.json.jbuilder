json.teacher do
  json.id @teacher.id
  json.fullname @teacher.fullname
  json.photo @teacher.photo
  json.email @teacher.email  
  json.description @teacher.description
  json.course @teacher.course
end

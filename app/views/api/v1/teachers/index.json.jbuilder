json.teachers(@teachers) do |teacher|
  json.id teacher.id
  json.fullname teacher.fullname
  json.email teacher.email
  json.photo teacher.photo
  json.course teacher.course
  json.description teacher.description
end
